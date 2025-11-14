import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/profile/profile_api.dart';
import '../../../data/profile/profile_repository_impl.dart';
import '../../../domain/profile/profile_entity.dart';
import '../../../domain/profile/profile_repository.dart';
import 'profile_onboarding_state.dart';

/// Provider für das Repository
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final client = Supabase.instance.client;
  final api = ProfileApi(client);
  return ProfileRepositoryImpl(api, client);
});

/// StateNotifierProvider für den Onboarding-State
final profileOnboardingNotifierProvider = StateNotifierProvider<ProfileOnboardingNotifier, ProfileOnboardingState>((
  ref,
) {
  final repo = ref.watch(profileRepositoryProvider);
  return ProfileOnboardingNotifier(repo);
});

class ProfileOnboardingNotifier extends StateNotifier<ProfileOnboardingState> {
  final ProfileRepository _repo;

  ProfileOnboardingNotifier(this._repo) : super(const ProfileOnboardingState()) {
    _init();
  }

  Future<void> _init() async {
    await loadProfile();
  }

  Future<void> loadProfile() async {
    state = state.copyWith(status: ProfileOnboardingStatus.loading);
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      state = state.copyWith(status: ProfileOnboardingStatus.error, errorMessage: 'No authenticated user found.');
      return;
    }
    try {
      final p = await _repo.getCurrentProfile(user.id);
      state = state.copyWith(status: ProfileOnboardingStatus.loaded, profile: p);
    } catch (e) {
      state = state.copyWith(status: ProfileOnboardingStatus.error, errorMessage: e.toString());
    }
  }

  Future<bool> saveProfile(Profile profile) async {
    state = state.copyWith(status: ProfileOnboardingStatus.saving);

    try {
      final saved = await _repo.upsertProfile(profile);
      state = state.copyWith(status: ProfileOnboardingStatus.loaded, profile: saved);
      return true;
    } catch (e) {
      state = state.copyWith(status: ProfileOnboardingStatus.error, errorMessage: e.toString());
      return false;
    }
  }

  Future<bool> updateProfile(Profile profile) async {
    state = state.copyWith(status: ProfileOnboardingStatus.saving);

    try {
      final saved = await _repo.updateProfile(profile);
      state = state.copyWith(status: ProfileOnboardingStatus.loaded, profile: saved);
      return true;
    } catch (e) {
      state = state.copyWith(status: ProfileOnboardingStatus.error, errorMessage: e.toString());
      return false;
    }
  }
}
