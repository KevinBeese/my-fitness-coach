// lib/scr/domain/profile/i_profile_repository.dart
import 'package:my_fitness_coach/scr/domain/profile/profile_entity.dart';

abstract class ProfileRepository {
  Future<Profile?> fetchProfile(String userId);
  Future<Profile> upsertProfile(Profile profile);
}
