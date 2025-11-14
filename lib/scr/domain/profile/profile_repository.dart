import 'profile_entity.dart';

abstract class ProfileRepository {
  Future<Profile?> getCurrentProfile(String userId);
  Future<Profile> upsertProfile(Profile profile);
  Future<void> deleteProfile(String userId);
  Future<Profile> updateProfile(Profile profile);
}
