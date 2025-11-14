class Profile {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime? birthDate;
  final double? heightCm;
  final double? weightKg;
  final String goal;

  const Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.heightCm,
    required this.weightKg,
    required this.goal,
  });

  Profile copyWith({
    String? id,
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    double? heightCm,
    double? weightKg,
    String? goal,
  }) {
    return Profile(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      goal: goal ?? this.goal,
    );
  }

  bool get isProfileComplete {
    return firstName.trim().isNotEmpty &&
        lastName.trim().isNotEmpty &&
        birthDate != null &&
        (heightCm ?? 0) > 0 &&
        (weightKg ?? 0) > 0 &&
        goal.trim().isNotEmpty;
  }
}
