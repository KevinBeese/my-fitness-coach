import 'package:hooks_riverpod/legacy.dart';
import 'package:my_fitness_coach/scr/domain/profile/profile_entity.dart';

import '../../../domain/profile/profile_repository.dart';
import 'profile_state.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository _repository;

  ProfileNotifier(this._repository) : super(const ProfileState());

  Future<void> loadProfile({required String userId}) async {
    state = state.copyWith(status: ProfileStatus.loading, errorMessage: null);

    try {
      final profile = await _repository.getCurrentProfile(userId);
      state = state.copyWith(status: ProfileStatus.loaded, profile: profile);
    } catch (e) {
      state = state.copyWith(status: ProfileStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> saveProfile({required Profile profile}) async {
    state = state.copyWith(status: ProfileStatus.saving, errorMessage: null);

    try {
      final saved = await _repository.upsertProfile(profile);
      state = state.copyWith(status: ProfileStatus.loaded, profile: saved);
    } catch (e) {
      state = state.copyWith(status: ProfileStatus.error, errorMessage: e.toString());
    }
  }
}
