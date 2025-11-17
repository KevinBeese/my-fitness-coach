// lib/scr/state/training/training_preferences_state.dart

import 'package:my_fitness_coach/scr/domain/profile/profile_entity.dart';

class TrainingPreferencesState {
  final String? userId;
  final Set<TrainingDay>? selectedDays;
  final int? weeklyTrainingHours;
  final bool isSaving;
  final bool wasSuccessful;
  final String? error;

  const TrainingPreferencesState({
    this.userId,
    this.selectedDays = const {},
    this.weeklyTrainingHours = 0,
    this.isSaving = false,
    this.wasSuccessful = false,
    this.error,
  });

  TrainingPreferencesState copyWith({
    String? userId,
    Set<TrainingDay>? selectedDays,
    int? weeklyTrainingHours,
    bool? isSaving,
    bool? wasSuccessful,
    String? error,
  }) {
    return TrainingPreferencesState(
      userId: userId ?? this.userId,
      selectedDays: selectedDays ?? this.selectedDays,
      weeklyTrainingHours: weeklyTrainingHours ?? this.weeklyTrainingHours,
      isSaving: isSaving ?? this.isSaving,
      wasSuccessful: wasSuccessful ?? this.wasSuccessful,
      error: error ?? this.error,
    );
  }
}
