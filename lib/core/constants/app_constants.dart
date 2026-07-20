class AppConstants {
  AppConstants._();

  static const String baseUrl = 'https://fakestoreapi.com';
  static const String productsEndpoint = '/products';
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);

  static const String dummyOtp = '123456';
  static const int mobileNumberLength = 10;
  static const int otpLength = 6;
  static const Duration simulatedAuthDelay = Duration(milliseconds: 700);

  static const double defaultPadding = 16.0;
  static const double cardBorderRadius = 16.0;
  static const double buttonBorderRadius = 12.0;
  static const Duration cardAnimationDuration = Duration(milliseconds: 350);
  static const Duration standardAnimationDuration = Duration(milliseconds: 300);
}
