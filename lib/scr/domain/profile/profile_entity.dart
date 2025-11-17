import 'package:my_fitness_coach/exports.dart';

const STRING_PROFILE_API_ID_NAME = 'id';
const STRING_PROFILE_API_FIRST_NAME = 'first_name';
const STRING_PROFILE_API_LAST_NAME = 'last_name';
const STRING_PROFILE_API_BIRTH_DATE = 'birth_date';
const STRING_PROFILE_API_HEIGHT_CM = 'height_cm';
const STRING_PROFILE_API_WEIGHT_KG = 'weight_kg';
const STRING_PROFILE_API_GOAL = 'goal';
const STRING_PROFILE_API_TRAINING_DAY = 'training_days';
const STRING_PROFILE_API_WEEKLY_TRAINING_HOURS = 'weekly_training_hours';

class Profile {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final double heightCm;
  final double weightKg;
  final String goal;
  final Set<TrainingDay>? trainingDays;
  final int? weeklyTrainingHours;

  const Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.heightCm,
    required this.weightKg,
    required this.goal,
    required this.trainingDays,
    required this.weeklyTrainingHours,
  });

  Profile copyWith({
    String? id,
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    double? heightCm,
    double? weightKg,
    String? goal,
    Set<TrainingDay>? trainingDays,
    int? weeklyTrainingHours,
  }) {
    return Profile(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      goal: goal ?? this.goal,
      trainingDays: trainingDays ?? this.trainingDays,
      weeklyTrainingHours: weeklyTrainingHours ?? this.weeklyTrainingHours,
    );
  }

  bool get isProfileComplete {
    return firstName.trim().isNotEmpty &&
        lastName.trim().isNotEmpty &&
        heightCm > 0 &&
        weightKg > 0 &&
        goal.trim().isNotEmpty;
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map[STRING_PROFILE_API_ID_NAME] as String,
      firstName: (map[STRING_PROFILE_API_FIRST_NAME] ?? '') as String,
      lastName: (map[STRING_PROFILE_API_LAST_NAME] ?? '') as String,
      birthDate: DateTime.tryParse(map[STRING_PROFILE_API_BIRTH_DATE] as String)!,
      heightCm: (map[STRING_PROFILE_API_HEIGHT_CM] as num).toDouble(),
      weightKg: (map[STRING_PROFILE_API_WEIGHT_KG] as num).toDouble(),
      goal: (map[STRING_PROFILE_API_GOAL] ?? '') as String,
      trainingDays: (map[STRING_PROFILE_API_TRAINING_DAY] as List<dynamic>?)
          ?.map((e) => TrainingDay.values.firstWhere((day) => day.name.toLowerCase() == (e as String).toLowerCase()))
          .toSet(),
      weeklyTrainingHours: map[STRING_PROFILE_API_WEEKLY_TRAINING_HOURS] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      STRING_PROFILE_API_ID_NAME: id,
      STRING_PROFILE_API_FIRST_NAME: firstName,
      STRING_PROFILE_API_LAST_NAME: lastName,
      STRING_PROFILE_API_BIRTH_DATE: birthDate.toIso8601String(),
      STRING_PROFILE_API_HEIGHT_CM: heightCm,
      STRING_PROFILE_API_WEIGHT_KG: weightKg,
      STRING_PROFILE_API_GOAL: goal,
      STRING_PROFILE_API_TRAINING_DAY: trainingDays?.map((e) => e.name).toSet(),
      STRING_PROFILE_API_WEEKLY_TRAINING_HOURS: weeklyTrainingHours,
    };
  }
}

enum TrainingDay {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  String get name {
    switch (this) {
      case TrainingDay.monday:
        return LocaleKeys.training_days_monday.tr();
      case TrainingDay.tuesday:
        return LocaleKeys.training_days_tuesday.tr();
      case TrainingDay.wednesday:
        return LocaleKeys.training_days_wednesday.tr();
      case TrainingDay.thursday:
        return LocaleKeys.training_days_thursday.tr();
      case TrainingDay.friday:
        return LocaleKeys.training_days_friday.tr();
      case TrainingDay.saturday:
        return LocaleKeys.training_days_saturday.tr();
      case TrainingDay.sunday:
        return LocaleKeys.training_days_sunday.tr();
    }
  }

  String toApiString() {
    return name.toLowerCase();
  }
}
