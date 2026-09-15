import 'package:Silink/features/profile_completion/presentation/profile_completion_screen.dart';
import 'package:Silink/features/profile_completion/presentation/usage_type_screen.dart';
import 'package:Silink/features/statistics/presentation/statistics_screen.dart';
import 'package:Silink/features/store/presentation/store_screen.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/otp_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/layout/presentation/layout_screen.dart';
import '../../features/onboarding/presentation/on_boarding_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import 'routes.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments as Map<String, dynamic>?;

    switch (settings.name) {
      case Routes.splashScreen:
        return _pageRoute(const SplashScreen());

      case Routes.onBoardingScreen:
        return _pageRoute(const OnBoardingScreen());

      case Routes.loginScreen:
        return _pageRoute(const LoginScreen());

      case Routes.registerScreen:
        return _pageRoute(const RegisterScreen());

      case Routes.otpScreen:
        return _pageRoute(
            OtpScreen(destination: arguments?['destination'] as String? ?? ''));

      case Routes.layoutScreen:
        return _pageRoute(
            LayoutScreen(currentPage: arguments?['currentPage'] ?? 0));

      case Routes.usageTypeScreen:
        return _pageRoute(const UsageTypeScreen());
      case Routes.profileCompletionScreen:
        return _pageRoute(const ProfileCompletionScreen());
      case Routes.statisticsScreen:
        return _pageRoute(const StatisticsScreen());
      case Routes.storeScreen:
        return _pageRoute(const StoreScreen());

      default:
        return _pageRoute(const _UndefinedScreen());
    }
  }

  static PageRoute<dynamic> _pageRoute(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}

class _UndefinedScreen extends StatelessWidget {
  const _UndefinedScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Page not found')),
    );
  }
}
