// lib/scr/presentation/state/profile/profile_notifier.dart
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:my_fitness_coach/scr/domain/profile/profile_entity.dart';
import 'package:my_fitness_coach/scr/domain/profile/profile_repository.dart';

class ProfileNotifier extends StateNotifier<AsyncValue<Profile?>> {
  final ProfileRepository _repo;
  final String? _userId;

  ProfileNotifier(this._repo, {String? userId}) : _userId = userId, super(const AsyncValue.loading()) {
    if (_userId != null) {
      loadProfile();
    } else {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> loadProfile() async {
    if (_userId == null) {
      state = const AsyncValue.data(null);
      return;
    }

    state = const AsyncValue.loading();
    try {
      final profile = await _repo.fetchProfile(_userId);
      state = AsyncValue.data(profile);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> saveProfile(Profile profile) async {
    state = const AsyncValue.loading();
    try {
      final updated = await _repo.upsertProfile(profile);
      state = AsyncValue.data(updated);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
