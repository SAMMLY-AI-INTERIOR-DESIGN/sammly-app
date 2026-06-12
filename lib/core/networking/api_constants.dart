abstract class ApiConstants {
  static const String baseUrl = '***REMOVED***';

  // Auth endpoints
  static const String register = '/api/auth/register';
  static const String login = '/api/auth/login';
  static const String verifyEmail = '/api/auth/email/verify';
  static const String forgotPassword = '/api/auth/password/forgot';
  static const String verifyPasswordReset = '/api/auth/password/verify';
  static const String resetPassword = '/api/auth/password/reset';
  static const String changePassword = '/api/auth/password/change';
  static const String resendVerificationCode = '/api/auth/email/resend-verification-code';
  static const String resendResetCode = '/api/auth/password/resend-reset-code';
  
  // Profile / Support endpoints
  static const String getProfile = '/api/profile';
  static const String editProfile = '/api/profile/edit';
  static const String support = '/api/support';

  // Design generation endpoints
  static const String generateDesign = '/api/designs/generate';

  // Favorite endpoints
  static const String getFavorites = '/api/designs/favorites';
  /// Use: '${ApiConstants.toggleFavorite}/$designId'
  static const String toggleFavorite = '/api/designs/favorites';
}
