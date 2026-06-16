import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/Auth/cubit/auth_states.dart';
import 'package:sammly/features/Auth/data/repo/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthInitialState());

  @override
  void emit(AuthState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  // ── Login ──
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());
    final result = await authRepo.login(email: email, password: password);
    result.fold((error) {
      if (error.startsWith('EMAIL_NOT_VERIFIED')) {
        final parts = error.split(':');
        final message = parts.length > 1 ? parts.sublist(1).join(':') : null;
        emit(AuthNeedsVerificationState(email: email, message: message));
      } else {
        emit(LoginFailedState(errorMsg: error));
      }
    }, (success) => emit(LoginSuccessState()));
  }

  // ── Register ──
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required bool termsAccepted,
    required bool privacyAccepted,
  }) async {
    emit(RegisterLoadingState());
    final result = await authRepo.register(
      name: name,
      email: email,
      password: password,
      termsAccepted: termsAccepted,
      privacyAccepted: privacyAccepted,
    );
    result.fold((error) {
      if (error.startsWith('EMAIL_NOT_VERIFIED')) {
        final parts = error.split(':');
        final message = parts.length > 1 ? parts.sublist(1).join(':') : null;
        emit(AuthNeedsVerificationState(email: email, message: message));
      } else {
        emit(RegisterFailedState(errorMsg: error));
      }
    }, (success) => emit(RegisterSuccessState()));
  }

  // ── Verify Register Code ──
  Future<void> verifyRegisterCode({
    required String email,
    required String code,
  }) async {
    emit(VerifyRegisterCodeLoadingState());
    final result = await authRepo.verifyRegisterCode(email: email, code: code);
    result.fold(
      (error) => emit(VerifyRegisterCodeFailedState(errorMsg: error)),
      (success) => emit(VerifyRegisterCodeSuccessState()),
    );
  }

  // ── Send Password Reset Code ──
  Future<void> sendPasswordResetCode({required String email}) async {
    emit(SendResetCodeLoadingState());
    final result = await authRepo.sendPasswordResetCode(email: email);
    result.fold(
      (error) => emit(SendResetCodeFailedState(errorMsg: error)),
      (success) => emit(SendResetCodeSuccessState()),
    );
  }

  // ── Verify Password Reset Code ──
  Future<void> verifyPasswordResetCode({
    required String email,
    required String code,
  }) async {
    emit(VerifyResetCodeLoadingState());
    final result = await authRepo.verifyPasswordResetCode(
      email: email,
      code: code,
    );
    result.fold(
      (error) => emit(VerifyResetCodeFailedState(errorMsg: error)),
      (success) => emit(VerifyResetCodeSuccessState()),
    );
  }

  // ── Reset Password ──
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    emit(ResetPasswordLoadingState());
    final result = await authRepo.resetPassword(
      email: email,
      newPassword: newPassword,
    );
    result.fold(
      (error) => emit(ResetPasswordFailedState(errorMsg: error)),
      (success) => emit(ResetPasswordSuccessState()),
    );
  }

  // ── Change Password ──
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(ChangePasswordLoadingState());
    final result = await authRepo.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    result.fold(
      (error) => emit(ChangePasswordFailedState(errorMsg: error)),
      (success) => emit(ChangePasswordSuccessState()),
    );
  }
}
