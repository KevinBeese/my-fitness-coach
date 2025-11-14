import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/auth/auth_notifier.dart';
import '../../state/auth/auth_state.dart';
import '../auth/login_screen.dart';
import '../profile/profile_gate.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    switch (authState.status) {
      case AuthStatus.unknown:
      case AuthStatus.loading:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case AuthStatus.unauthenticated:
      case AuthStatus.error:
        return const LoginScreen();
      case AuthStatus.authenticated:
        // Eingeloggt → jetzt Profil-Flow entscheiden lassen
        return const ProfileGate();
    }
  }
}
