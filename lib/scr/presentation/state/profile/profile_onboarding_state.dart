import '../../../domain/profile/profile_entity.dart';

enum ProfileOnboardingStatus { initial, loading, loaded, saving, error }

class ProfileOnboardingState {
  final ProfileOnboardingStatus status;
  final Profile? profile;
  final String? errorMessage;

  const ProfileOnboardingState({this.status = ProfileOnboardingStatus.initial, this.profile, this.errorMessage});

  bool get isLoading => status == ProfileOnboardingStatus.loading || status == ProfileOnboardingStatus.saving;

  ProfileOnboardingState copyWith({ProfileOnboardingStatus? status, Profile? profile, String? errorMessage}) {
    return ProfileOnboardingState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage,
    );
  }
}
