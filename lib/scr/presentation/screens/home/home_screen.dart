import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_fitness_coach/scr/presentation/app/routes/app_routes.dart';
import 'package:my_fitness_coach/scr/presentation/state/auth/auth_provider.dart';
import 'package:my_fitness_coach/scr/presentation/state/auth/auth_state.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authNotifierProvider.notifier);

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next.status == AuthStatus.unknown) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.root);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [IconButton(onPressed: () => authNotifier.signOut(), icon: Icon(Icons.logout))],
      ),
      body: Column(
        children: [
          Center(child: Text('Home Screen – Training, Stats, etc.')),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.onboarding),
            child: Text('User Profile'),
          ),
        ],
      ),
    );
  }
}
