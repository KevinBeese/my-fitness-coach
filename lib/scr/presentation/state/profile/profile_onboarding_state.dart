import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../domain/profile/profile_entity.dart';

enum ProfileOnboardingStatus { initial, loading, loaded, saving, error }

class ProfileOnboardingState {
  final ProfileOnboardingStatus status;
  final Profile? profile;
  final User? user;
  final String? errorMessage;

  const ProfileOnboardingState({
    this.status = ProfileOnboardingStatus.initial,
    this.profile,
    this.user,
    this.errorMessage,
  });

  bool get isLoading => status == ProfileOnboardingStatus.loading || status == ProfileOnboardingStatus.saving;

  ProfileOnboardingState copyWith({
    ProfileOnboardingStatus? status,
    Profile? profile,
    User? user,
    String? errorMessage,
  }) {
    return ProfileOnboardingState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }
}
