class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://silink-api.nsq4.sa/api/v1/';

  // ─── Auth ─────────────────────────────────────────────────────────────────
  static const String login = 'auth/login';
  static const String profile = 'me/profile';
  static const String register = 'auth/register';
  static const String verifyOtp = 'auth/otp/verify';
}
