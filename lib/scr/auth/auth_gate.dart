import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_fitness_coach/scr/presentation/screens/auth/auth_screen.dart';
import 'package:my_fitness_coach/scr/presentation/screens/auth/email_verification_screen.dart';
import 'package:my_fitness_coach/scr/presentation/screens/profile/profile_gate.dart';
import 'package:my_fitness_coach/scr/presentation/state/auth/auth_provider.dart';
import 'package:my_fitness_coach/scr/presentation/state/auth/auth_state.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authNotifierProvider);

    final authState = ref.watch(authNotifierProvider.select((state) => state));
    switch (authNotifier.status) {
      case AuthStatus.unauthenticated:
        return EmailVerificationScreen(
          email: authState.email ?? '',
          password: authState.password ?? '',
        );
      case AuthStatus.error:
      case AuthStatus.authenticated:
        return const ProfileGate();
      case AuthStatus.loading:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case AuthStatus.unknown:
        return const AuthScreen();
    }
  }
}
