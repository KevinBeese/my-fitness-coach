import 'package:flutter/material.dart';
import 'package:my_fitness_coach/scr/auth/auth_gate.dart';
import 'package:my_fitness_coach/scr/presentation/screens/auth/email_verification_screen.dart';
import 'package:my_fitness_coach/scr/presentation/screens/auth/login_screen.dart';
import 'package:my_fitness_coach/scr/presentation/screens/home/home_screen.dart';
import 'package:my_fitness_coach/scr/presentation/screens/profile/onboarding_screen.dart';
import 'package:my_fitness_coach/scr/presentation/screens/profile/profile_screen.dart';

class AppRoute {
  final String path;

  const AppRoute(this.path);

  static const root = AppRoute(AppRoutes.root);
  static const login = AppRoute(AppRoutes.login);
  static const onboarding = AppRoute(AppRoutes.onboarding);
  static const home = AppRoute(AppRoutes.home);
  static const profile = AppRoute(AppRoutes.profile);
  static const verifyEmail = AppRoute(AppRoutes.verifyEmail);
}

abstract class AppRoutes {
  static const root = '/';
  static const login = '/login';
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const profile = '/profile';
  static const verifyEmail = '/verify-email';
}

final appRoutes = {
  AppRoutes.root: (_) => const AuthGate(),
  AppRoutes.login: (_) => const LoginScreen(),
  AppRoutes.onboarding: (_) => const OnboardingScreen(),
  AppRoutes.home: (_) => const HomeScreen(),
  AppRoutes.profile: (_) => const ProfileScreen(),
  AppRoutes.verifyEmail: (ctx) {
    final args = ModalRoute.of(ctx)?.settings.arguments as Map<String, String>?;
    final email = args?['email'] ?? '';
    final password = args?['password'] ?? '';
    return EmailVerificationScreen(email: email, password: password);
  },
};
