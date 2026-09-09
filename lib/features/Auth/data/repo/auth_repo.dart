import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sammly/core/networking/api_constants.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/core/utils/backend_message_translator.dart';


class AuthRepo {
  static String _t(String msg) => BackendMessageTranslator.translate(msg);

  /// Sign in with Google.
  /// Gets the Google idToken and sends it to POST /api/auth/google
  Future<Either<String, String>> googleSignIn() async {
    try {
      final signIn = GoogleSignIn.instance;

      // Initialize with serverClientId to get idToken
      await signIn.initialize(
        serverClientId:
            '448399464725-1mm93gt53865cqiehagq4d1ommqf1tkd.apps.googleusercontent.com',
      );

      // Safely attempt sign out first to clear previous session if any
      try {
        await signIn.signOut();
      } catch (_) {}

      // Trigger the sign-in flow — returns GoogleSignInAccount directly
      final GoogleSignInAccount account = await signIn.authenticate();

      // Get the idToken
      final String? idToken = account.authentication.idToken;

      if (idToken == null) {
        return left(_t('Failed to get Google ID token.'));
      }

      print('📋 Google idToken: $idToken');

      // Send the idToken to the backend
      final response = await DioHelper.postData(
        endPoint: ApiConstants.googleAuth,
        data: {'idToken': idToken},
      );

      if (response.data['success'] == true ||
          response.data['status'] == 'success' ||
          response.statusCode == 200 ||
          response.statusCode == 201) {
        final token = response.data['data']?['token'] ?? response.data['token'];
        if (token != null) {
          await SharedPref.saveData(key: 'jwt', value: token);
        }
        final successMsg =
            response.data['message'] ??
            response.data['msg'] ??
            (response.data['data'] is Map
                ? (response.data['data']['msg'] ??
                      response.data['data']['message'])
                : null);
        return right(_t(successMsg?.toString() ?? 'Signed in with Google.'));
      } else {
        final msg =
            response.data['message']?.toString() ??
            response.data['msg']?.toString() ??
            '';
        return left(msg.isNotEmpty ? _t(msg) : _t('Google sign in failed.'));
      }
    } on GoogleSignInException catch (e) {
      print('❌ Google Sign-In exception: code=${e.code}, description=${e.description}');
      if (e.code == GoogleSignInExceptionCode.canceled ||
          e.code == GoogleSignInExceptionCode.interrupted) {
        return left(_t('Sign in cancelled.'));
      }
      return left(_t('Google sign in failed (${e.code.name}: ${e.description ?? ''})'));
    } on DioException catch (e) {
      final msg = _extractErrorMessage(e);
      print('❌ Google Sign-In DioException: msg=$msg, data=${e.response?.data}');
      return left(msg.isNotEmpty ? _t(msg) : _handleDioError(e));
    } catch (e) {
      print('❌ Google Sign-In error: $e');
      return left(_t('An unexpected error occurred.'));
    }
  }
  /// Register a new user account.
  /// POST /api/auth/register
  Future<Either<String, String>> register({
    required String name,
    required String email,
    required String password,
    required bool termsAccepted,
    required bool privacyAccepted,
  }) async {
    try {
      final response = await DioHelper.postData(
        endPoint: ApiConstants.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'termsAccepted': termsAccepted,
          'privacyAccepted': privacyAccepted,
        },
      );

      // 201 or success:true → account created, verification code sent
      if (response.data['success'] == true ||
          response.data['status'] == 'success' ||
          response.statusCode == 201) {
        final successMsg =
            response.data['message'] ??
            response.data['msg'] ??
            (response.data['data'] is Map
                ? (response.data['data']['msg'] ??
                      response.data['data']['message'])
                : null);
        return right(_t(successMsg?.toString() ?? 'Account created successfully.'));
      } else {
        final msg =
            response.data['message']?.toString() ??
            response.data['msg']?.toString() ??
            '';
        if (_isVerificationError(msg)) {
          return left('EMAIL_NOT_VERIFIED');
        }
        return left(msg.isNotEmpty ? _t(msg) : _t('Registration failed.'));
      }
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final msg = _extractErrorMessage(e);
      print(
        '❌ Register DioException: statusCode=$statusCode, msg=$msg, data=${e.response?.data}',
      );
      if (statusCode == 409) {
        if (_isVerificationError(msg)) {
          return left('EMAIL_NOT_VERIFIED:${_t(msg)}');
        } else {
          return left(msg.isNotEmpty ? _t(msg) : _t('Email already exists.'));
        }
      } else if (statusCode == 403) {
        return left(
          msg.isNotEmpty ? _t(msg) : _t('Your account has been deactivated.'),
        );
      } else if (statusCode == 429) {
        // Always route to verification screen on 429, but pass the wait message
        return left(
          'EMAIL_NOT_VERIFIED:${msg.isNotEmpty ? _t(msg) : _t('Too many requests. Please wait.')}',
        );
      }

      if (_isVerificationError(msg)) {
        return left('EMAIL_NOT_VERIFIED:${_t(msg)}');
      }

      return left(msg.isNotEmpty ? _t(msg) : _handleDioError(e));
    } catch (e) {
      return left(_t('An unexpected error occurred.'));
    }
  }

  /// Verify the email code sent during registration.
  /// POST /api/auth/email/verify → returns JWT
  Future<Either<String, String>> verifyRegisterCode({
    required String email,
    required String code,
  }) async {
    try {
      final response = await DioHelper.postData(
        endPoint: ApiConstants.verifyEmail,
        data: {'email': email, 'code': code},
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.data['success'] == true ||
          response.data['status']?.toString().toLowerCase() == 'success') {
        final token = response.data['data']?['token'];
        if (token != null) {
          await SharedPref.saveData(key: 'jwt', value: token);
        }
        final successMsg =
            response.data['message'] ??
            response.data['msg'] ??
            (response.data['data'] is Map
                ? (response.data['data']['msg'] ??
                      response.data['data']['message'])
                : null);
        return right(_t(successMsg?.toString() ?? 'Email verified.'));
      } else {
        return left(_t('Verification failed.'));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(_t('An unexpected error occurred.'));
    }
  }

  /// Resend the email verification code.
  /// POST /api/auth/email/resend-verification-code
  Future<Either<String, String>> resendVerificationCode({
    required String email,
  }) async {
    try {
      final response = await DioHelper.postData(
        endPoint: ApiConstants.resendVerificationCode,
        data: {'email': email},
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.data['success'] == true ||
          response.data['status']?.toString().toLowerCase() == 'success') {
        final successMsg =
            response.data['message'] ??
            response.data['msg'] ??
            (response.data['data'] is Map
                ? (response.data['data']['msg'] ??
                      response.data['data']['message'])
                : null);
        return right(
          _t(successMsg?.toString() ?? 'Verification code resent successfully.'),
        );
      } else {
        return left(_t('Failed to resend verification code.'));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(_t('An unexpected error occurred.'));
    }
  }

  /// Login with existing credentials.
  /// POST /api/auth/login → returns JWT
  Future<Either<String, String>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioHelper.postData(
        endPoint: ApiConstants.login,
        data: {'email': email, 'password': password},
      );

      print(
        '📋 Login response: statusCode=${response.statusCode}, data=${response.data}',
      );
      if (response.data['success'] == true ||
          response.data['status'] == 'success') {
        final token = response.data['data']?['token'] ?? response.data['token'];
        if (token != null) {
          // Decode JWT to check for 'pending' status
          try {
            final parts = token.split('.');
            if (parts.length == 3) {
              final payloadStr = utf8.decode(
                base64Url.decode(base64Url.normalize(parts[1])),
              );
              final payload = jsonDecode(payloadStr);
              if (payload['status'] == 'pending') {
                return left('EMAIL_NOT_VERIFIED');
              }
            }
          } catch (_) {}

          await SharedPref.saveData(key: 'jwt', value: token);
        }
        final successMsg =
            response.data['message'] ??
            response.data['msg'] ??
            (response.data['data'] is Map
                ? (response.data['data']['msg'] ??
                      response.data['data']['message'])
                : null);
        return right(_t(successMsg?.toString() ?? 'Logged in.'));
      } else {
        final msg =
            response.data['message']?.toString() ??
            response.data['msg']?.toString() ??
            '';
        if (_isVerificationError(msg)) {
          return left('EMAIL_NOT_VERIFIED');
        }
        return left(msg.isNotEmpty ? _t(msg) : _t('Login failed.'));
      }
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final msg = _extractErrorMessage(e);
      print(
        '❌ Login DioException: statusCode=$statusCode, msg=$msg, data=${e.response?.data}',
      );
      if (statusCode == 409) {
        if (_isVerificationError(msg)) {
          return left('EMAIL_NOT_VERIFIED:${_t(msg)}');
        } else {
          return left(msg.isNotEmpty ? _t(msg) : _t('Conflict error.'));
        }
      } else if (statusCode == 403) {
        if (_isVerificationError(msg)) {
          return left('EMAIL_NOT_VERIFIED:${_t(msg)}');
        } else {
          return left(
            msg.isNotEmpty ? _t(msg) : _t('Your account has been deactivated.'),
          );
        }
      } else if (statusCode == 429) {
        // Always route to verification screen on 429, but pass the wait message
        return left(
          'EMAIL_NOT_VERIFIED:${msg.isNotEmpty ? _t(msg) : _t('Too many requests. Please wait.')}',
        );
      }

      if (_isVerificationError(msg)) {
        return left('EMAIL_NOT_VERIFIED:${_t(msg)}');
      }

      return left(msg.isNotEmpty ? _t(msg) : _handleDioError(e));
    } catch (e) {
      return left(_t('An unexpected error occurred.'));
    }
  }

  /// Send a password reset code to the user's email.
  /// POST /api/auth/password/forgot
  Future<Either<String, String>> sendPasswordResetCode({
    required String email,
  }) async {
    try {
      final response = await DioHelper.postData(
        endPoint: ApiConstants.forgotPassword,
        data: {'email': email},
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.data['success'] == true ||
          response.data['status']?.toString().toLowerCase() == 'success') {
        final successMsg =
            response.data['message'] ??
            response.data['msg'] ??
            (response.data['data'] is Map
                ? (response.data['data']['msg'] ??
                      response.data['data']['message'])
                : null);
        return right(_t(successMsg?.toString() ?? 'Reset code sent.'));
      } else {
        return left(_t('Failed to send reset code.'));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(_t('An unexpected error occurred.'));
    }
  }

  /// Resend a password reset code to the user's email.
  /// POST /api/auth/password/resend-reset-code
  Future<Either<String, String>> resendResetCode({
    required String email,
  }) async {
    try {
      final response = await DioHelper.postData(
        endPoint: ApiConstants.resendResetCode,
        data: {'email': email},
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.data['success'] == true ||
          response.data['status']?.toString().toLowerCase() == 'success') {
        final successMsg =
            response.data['message'] ??
            response.data['msg'] ??
            (response.data['data'] is Map
                ? (response.data['data']['msg'] ??
                      response.data['data']['message'])
                : null);
        return right(
          _t(successMsg?.toString() ?? 'Reset code resent successfully.'),
        );
      } else {
        return left(_t('Failed to resend reset code.'));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(_t('An unexpected error occurred.'));
    }
  }

  /// Verify the password reset code.
  /// POST /api/auth/password/verify
  Future<Either<String, String>> verifyPasswordResetCode({
    required String email,
    required String code,
  }) async {
    try {
      final response = await DioHelper.postData(
        endPoint: ApiConstants.verifyPasswordReset,
        data: {'email': email, 'code': code},
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.data['success'] == true ||
          response.data['status']?.toString().toLowerCase() == 'success') {
        final successMsg =
            response.data['message'] ??
            response.data['msg'] ??
            (response.data['data'] is Map
                ? (response.data['data']['msg'] ??
                      response.data['data']['message'])
                : null);
        return right(_t(successMsg?.toString() ?? 'Code verified.'));
      } else {
        return left(_t('Invalid or expired code.'));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(_t('An unexpected error occurred.'));
    }
  }

  /// Reset the password after code verification.
  /// PATCH /api/auth/password/reset
  Future<Either<String, String>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      final response = await DioHelper.patchData(
        endPoint: ApiConstants.resetPassword,
        data: {'email': email, 'newPassword': newPassword},
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.data['success'] == true ||
          response.data['status']?.toString().toLowerCase() == 'success') {
        final successMsg =
            response.data['message'] ??
            response.data['msg'] ??
            (response.data['data'] is Map
                ? (response.data['data']['msg'] ??
                      response.data['data']['message'])
                : null);
        return right(_t(successMsg?.toString() ?? 'Password reset successfully.'));
      } else {
        return left(_t('Failed to reset password.'));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(_t('An unexpected error occurred.'));
    }
  }

  /// Change password while logged in.
  /// PATCH /api/auth/password/change — requires JWT
  Future<Either<String, String>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      final response = await DioHelper.patchData(
        endPoint: ApiConstants.changePassword,
        data: {'oldPassword': oldPassword, 'newPassword': newPassword},
        token: token,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.data['success'] == true ||
          response.data['status']?.toString().toLowerCase() == 'success') {
        // Save the new JWT if returned
        final newToken = response.data['data']?['token'];
        if (newToken != null) {
          await SharedPref.saveData(key: 'jwt', value: newToken);
        }
        final successMsg =
            response.data['message'] ??
            response.data['msg'] ??
            (response.data['data'] is Map
                ? (response.data['data']['msg'] ??
                      response.data['data']['message'])
                : null);
        return right(_t(successMsg?.toString() ?? 'Password changed.'));
      } else {
        return left(_t('Failed to change password.'));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(_t('An unexpected error occurred.'));
    }
  }

  /// Centralized Dio error handler
  String _handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      try {
        final data = e.response!.data;
        if (data is Map) {
          final msg =
              data['message'] ??
              data['msg'] ??
              (data['data'] is Map
                  ? (data['data']['msg'] ?? data['data']['message'])
                  : null);
          if (msg != null) return _t(msg.toString());
        }
      } catch (_) {}
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return _t('Server Failed Connection , Try again');
      case DioExceptionType.badResponse:
        return _t('Bad response: ${e.response?.statusCode} - ${e.message}');
      default:
        return _t('Error: ${e.message ?? e.error ?? 'Something went wrong.'}');
    }
  }

  /// Extract error message string from a DioException response
  String _extractErrorMessage(DioException e) {
    try {
      final data = e.response?.data;
      if (data is Map) {
        return (data['message'] ??
                data['msg'] ??
                (data['data'] is Map
                    ? (data['data']['msg'] ?? data['data']['message'])
                    : null) ??
                '')
            .toString();
      }
    } catch (_) {}
    return '';
  }

  bool _isVerificationError(String msg) {
    final lower = msg.toLowerCase();
    return lower.contains('verif') ||
        lower.contains('not verified') ||
        lower.contains('verify your') ||
        lower.contains('verification code') ||
        lower.contains('confirm your email') ||
        lower.contains('email not confirmed') ||
        lower.contains('not activated');
  }
}
