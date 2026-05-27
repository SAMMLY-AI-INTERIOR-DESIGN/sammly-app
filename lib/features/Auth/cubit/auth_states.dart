abstract class AuthState {}

// ── Initial ──
class AuthInitialState extends AuthState {}

// ── Login ──
class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginFailedState extends AuthState {
  final String errorMsg;
  LoginFailedState({required this.errorMsg});
}

// ── Register ──
class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class RegisterFailedState extends AuthState {
  final String errorMsg;
  RegisterFailedState({required this.errorMsg});
}

// ── Verify Register Code (email verification after signup) ──
class VerifyRegisterCodeLoadingState extends AuthState {}

class VerifyRegisterCodeSuccessState extends AuthState {}

class VerifyRegisterCodeFailedState extends AuthState {
  final String errorMsg;
  VerifyRegisterCodeFailedState({required this.errorMsg});
}

// ── Send Password Reset Code ──
class SendResetCodeLoadingState extends AuthState {}

class SendResetCodeSuccessState extends AuthState {}

class SendResetCodeFailedState extends AuthState {
  final String errorMsg;
  SendResetCodeFailedState({required this.errorMsg});
}

// ── Verify Password Reset Code ──
class VerifyResetCodeLoadingState extends AuthState {}

class VerifyResetCodeSuccessState extends AuthState {}

class VerifyResetCodeFailedState extends AuthState {
  final String errorMsg;
  VerifyResetCodeFailedState({required this.errorMsg});
}

// ── Reset Password ──
class ResetPasswordLoadingState extends AuthState {}

class ResetPasswordSuccessState extends AuthState {}

class ResetPasswordFailedState extends AuthState {
  final String errorMsg;
  ResetPasswordFailedState({required this.errorMsg});
}

// ── Change Password ──
class ChangePasswordLoadingState extends AuthState {}

class ChangePasswordSuccessState extends AuthState {}

class ChangePasswordFailedState extends AuthState {
  final String errorMsg;
  ChangePasswordFailedState({required this.errorMsg});
}

// ── Shared Error / Navigation States ──
class AuthNeedsVerificationState extends AuthState {
  final String email;
  final String? message;
  AuthNeedsVerificationState({required this.email, this.message});
}