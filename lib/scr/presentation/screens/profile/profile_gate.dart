import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/profile/profile_onboarding_notifier.dart';
import '../../state/profile/profile_onboarding_state.dart';
import '../home/home_screen.dart';
import 'profile_onboarding_screen.dart';

class ProfileGate extends HookConsumerWidget {
  const ProfileGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileOnboardingNotifierProvider);

    if (state.status == ProfileOnboardingStatus.initial ||
        state.status == ProfileOnboardingStatus.loading ||
        state.status == ProfileOnboardingStatus.saving) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.status == ProfileOnboardingStatus.error) {
      return Scaffold(body: Center(child: Text(state.errorMessage ?? 'Fehler beim Laden des Profils')));
    }

    final profile = state.profile;

    if (profile == null || !profile.isProfileComplete) {
      return const ProfileOnboardingScreen();
    }

    return const HomeScreen();
  }
}
