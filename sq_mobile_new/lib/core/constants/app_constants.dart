// lib/core/constants/app_constants.dart

class AppConstants {
  AppConstants._();

  // API
  static const String apiBaseUrl      = 'http://192.168.1.34:3000/api/v1';
  static const String socketUrl       = 'http://192.168.1.34:3000';

  // Secure storage keys
  static const String accessTokenKey  = 'sq_access_token';
  static const String refreshTokenKey = 'sq_refresh_token';
  static const String onboardingKey   = 'sq_onboarding_done';

  // Pagination
  static const int defaultLimit       = 20;

  // Seuil rappel position
  static const int reminderThreshold  = 3;
}
