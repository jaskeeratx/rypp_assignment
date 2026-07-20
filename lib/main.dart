import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/booking_provider.dart';
import 'providers/product_provider.dart';
import 'routes/app_routes.dart';
import 'services/api_service.dart';
import 'services/auth_service.dart';
import 'services/storage_service.dart';

void main() {
  runApp(const BikeScooterRentalApp());
}

class BikeScooterRentalApp extends StatelessWidget {
  const BikeScooterRentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<StorageService>(create: (_) => StorageService()),
        Provider<ApiService>(create: (_) => ApiService()),
        ProxyProvider<StorageService, AuthService>(
          update: (_, storageService, __) => AuthService(storageService),
        ),
        ChangeNotifierProxyProvider<AuthService, AuthProvider>(
          create: (context) =>
              AuthProvider(context.read<AuthService>()),
          update: (_, authService, previous) =>
              previous ?? AuthProvider(authService),
        ),
        ChangeNotifierProxyProvider<ApiService, ProductProvider>(
          create: (context) =>
              ProductProvider(context.read<ApiService>()),
          update: (_, apiService, previous) =>
              previous ?? ProductProvider(apiService),
        ),
        ChangeNotifierProvider<BookingProvider>(
          create: (_) => BookingProvider(),
        ),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
