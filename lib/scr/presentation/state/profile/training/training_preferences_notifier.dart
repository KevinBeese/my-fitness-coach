// lib/scr/state/training/training_preferences_notifier.dart

import 'package:hooks_riverpod/legacy.dart';
import 'package:my_fitness_coach/scr/data/profile/profile_api.dart';
import 'package:my_fitness_coach/scr/domain/profile/profile_entity.dart';
import 'package:my_fitness_coach/scr/presentation/state/profile/training/training_preferences_state.dart';

const MAX_TRAINING_HOURS_PER_WEEK = 18;

final trainingPreferencesProvider =
    StateNotifierProvider.autoDispose<TrainingPreferencesNotifier, TrainingPreferencesState>(
      (ref) => TrainingPreferencesNotifier(ref.read(profileApiProvider)),
    );

class TrainingPreferencesNotifier extends StateNotifier<TrainingPreferencesState> {
  final ProfileApi _profileApi;
  TrainingPreferencesNotifier(this._profileApi) : super(const TrainingPreferencesState()) {
    initial();
  }

  Future<void> initial() async {
    final profile = await _profileApi.fetchProfileForUser();
    final selectedDays = profile?.trainingDays?.toSet() ?? {};
    final weeklyHours = profile?.weeklyTrainingHours ?? 0;
    state = state.copyWith(userId: profile?.id, selectedDays: selectedDays, weeklyTrainingHours: weeklyHours);
  }

  void toggleDay(TrainingDay day) {
    final current = Set<TrainingDay>.from(state.selectedDays ?? <TrainingDay>{});
    if (current.contains(day)) {
      current.remove(day);
    } else {
      current.add(day);
    }
    state = state.copyWith(selectedDays: current);
  }

  void setWeeklyTrainingHours(int hours) {
    state = state.copyWith(weeklyTrainingHours: hours.clamp(0, MAX_TRAINING_HOURS_PER_WEEK));
  }

  Future<void> save() async {
    state = state.copyWith(isSaving: true);
    final trainingDays = state.selectedDays;
    final weeklyTrainingHours = state.weeklyTrainingHours;
    if (state.userId == null) {
      state = state.copyWith(isSaving: false, error: 'User ID is null');
      state = state.copyWith(error: null);
      return;
    }

    try {
      await _profileApi.updateTrainingPreferences(
        profileId: state.userId ?? '',
        trainingDays: trainingDays?.map((e) => e.toApiString()).toList() ?? [],
        weeklyTrainingMinutes: weeklyTrainingHours ?? 0,
      );
      state = state.copyWith(isSaving: false, wasSuccessful: true);
      state = state.copyWith(wasSuccessful: false);
    } catch (e) {
      state = state.copyWith(isSaving: false, error: e.toString());
      state = state.copyWith(error: null);
      rethrow;
    }
  }
}
