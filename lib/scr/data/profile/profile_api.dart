import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/profile/profile_entity.dart';

const String API_TABLE_NAME_PROFILES = 'profiles';
const String API_ID_FIELD = 'id';

final profileApiProvider = Provider<ProfileApi>((ref) {
  final client = Supabase.instance.client;
  return ProfileApi(client);
});

class ProfileApi {
  final SupabaseClient supabaseClient;

  ProfileApi(this.supabaseClient);

  Future<Profile?> fetchProfileForUser() async {
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId == null) return null;
    final response = await supabaseClient.from(API_TABLE_NAME_PROFILES).select().eq(API_ID_FIELD, userId).maybeSingle();
    if (response == null) return null;
    return Profile.fromMap(response);
  }

  Future<Profile> upsertProfile(Profile profile) async {
    final response = await supabaseClient.from(API_TABLE_NAME_PROFILES).upsert(profile.toMap()).select().single();
    return Profile.fromMap(response);
  }

  Future<Profile> updateTrainingPreferences({
    required String profileId,
    required List<String> trainingDays,
    required int weeklyTrainingMinutes,
  }) async {
    final response = await supabaseClient
        .from(API_TABLE_NAME_PROFILES)
        .update({
          STRING_PROFILE_API_TRAINING_DAY: trainingDays,
          STRING_PROFILE_API_WEEKLY_TRAINING_HOURS: weeklyTrainingMinutes,
        })
        .eq(API_ID_FIELD, profileId)
        .select()
        .single();

    return Profile.fromMap(response);
  }
}
