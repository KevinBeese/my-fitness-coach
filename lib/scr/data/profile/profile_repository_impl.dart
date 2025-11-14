import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/profile/profile_entity.dart';
import '../../domain/profile/profile_repository.dart';
import 'profile_api.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApi _api;
  final SupabaseClient _client;

  ProfileRepositoryImpl(this._api, this._client);

  @override
  Future<Profile?> getCurrentProfile(String userId) async {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    return _api.fetchProfileForUser(user.id);
  }

  @override
  Future<Profile> upsertProfile(Profile profile) async {
    return _api.upsertProfile(profile);
  }
}
