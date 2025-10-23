import 'package:flutter/material.dart';
import '../../features/Login/login_screen.dart';
import '../../features/onbording/onboarding_screen.dart';


class AppRoutes {
  static const String onboarding = '/';
  static const String login = '/login';

  static Map<String, WidgetBuilder> routes = {
    onboarding: (context) => const OnboardingScreen(),
    login: (context) => const LoginScreen(),
  };
}