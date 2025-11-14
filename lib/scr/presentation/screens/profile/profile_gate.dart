import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/profile/profile_onboarding_notifier.dart';
import '../../state/profile/profile_onboarding_state.dart';
import '../home/home_screen.dart';
import 'onboarding_screen.dart';

class ProfileGate extends HookConsumerWidget {
  const ProfileGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileOnboardingNotifierProvider);
    final notifier = ref.read(profileOnboardingNotifierProvider.notifier);

    // beim ersten Mal Profil laden
    if (state.status == ProfileOnboardingStatus.initial) {
      notifier.loadProfile();
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.status == ProfileOnboardingStatus.loading && state.profile == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final profile = state.profile;

    if (profile == null || !profile.isProfileComplete) {
      // Kein oder unvollständiges Profil → Onboarding
      return const OnboardingScreen();
    }

    // Profil ist vollständig → Home
    return const HomeScreen();
  }
}
