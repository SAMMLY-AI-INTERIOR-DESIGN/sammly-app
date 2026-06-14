abstract class ApiConstants {
  static const String baseUrl = 'https://sammly-backend-p3z7.onrender.com';

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
  static const String restyleDesign = '/api/designs/restyle';
  static const String fullHomeDesign = '/api/designs/full-home';

  // Design history endpoints
  static const String designHistory = '/api/designs/history';

  // Shared explore endpoints
  static const String sharedDesigns = '/api/designs/shared';

  // Static designs endpoints
  static const String staticDesigns = '/api/designs/static-designs';

  // Design details & actions endpoints
  static String designDetails(String designId) => '/api/designs/$designId';
  static String shareDesign(String designId) => '/api/designs/$designId/share';
  static String cancelShareDesign(String designId) => '/api/designs/$designId/cancel-share';
  static String likeDesign(String designId) => '/api/designs/$designId/like';

  // Favorites endpoints
  static const String favorites = '/api/designs/favorites';
  static String favoriteDesign(String designId) => '/api/designs/favorites/$designId';

  // Home endpoint
  static const String homeEndpoint = '/api/profile/home';

  // Settings endpoint
  static const String settingsEndpoint = '/api/profile/settings';

  // Following endpoints
  static const String getFollows = '/api/profile/follows';
  static String followProfile(String userId) => '/api/profile/follows/$userId';

  // Notifications endpoint
  static const String getNotifications = '/api/profile/notifications';

  // Smart Lens search endpoint
  static String searchDesign(String designId) => '/api/designs/search/$designId';
}
