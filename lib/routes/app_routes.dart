import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../screens/booking/booking_screen.dart';
import '../screens/details/details_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/otp/otp_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/success/success_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String home = '/home';
  static const String details = '/details';
  static const String booking = '/booking';
  static const String success = '/success';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _page(const SplashScreen(), settings);

      case login:
        return _page(const LoginScreen(), settings);

      case otp:
        final mobile = settings.arguments as String? ?? '';
        return _page(OtpScreen(mobileNumber: mobile), settings);

      case home:
        return _page(const HomeScreen(), settings);

      case details:
        final product = settings.arguments as ProductModel;
        return _page(DetailsScreen(product: product), settings);

      case booking:
        final product = settings.arguments as ProductModel;
        return _page(BookingScreen(product: product), settings);

      case success:
        return _page(const SuccessScreen(), settings);

      default:
        return _page(
          Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
          settings,
        );
    }
  }

  static PageRoute<dynamic> _page(Widget child, RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => child, settings: settings);
  }
}
