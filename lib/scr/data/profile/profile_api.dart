import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/profile/profile_entity.dart';

class ProfileApi {
  final SupabaseClient client;

  ProfileApi(this.client);

  Future<Profile?> fetchProfileForUser(String userId) async {
    final res = await client.from('profiles').select().eq('id', userId).maybeSingle();

    if (res == null) return null;

    return Profile(
      id: res['id'] as String,
      firstName: (res['first_name'] ?? '') as String,
      lastName: (res['last_name'] ?? '') as String,
      birthDate: (res['birth_date'] as String?) != null ? DateTime.tryParse(res['birth_date'] as String) : null,
      heightCm: (res['height_cm'] as num?)?.toDouble(),
      weightKg: (res['weight_kg'] as num?)?.toDouble(),
      goal: (res['goal'] ?? '') as String,
    );
  }

  Future<Profile> upsertProfile(Profile profile) async {
    final res = await client
        .from('profiles')
        .upsert({
          'id': profile.id,
          'first_name': profile.firstName,
          'last_name': profile.lastName,
          'birth_date': profile.birthDate?.toIso8601String(),
          'height_cm': profile.heightCm,
          'weight_kg': profile.weightKg,
          'goal': profile.goal,
        })
        .select()
        .single();

    return Profile(
      id: res['id'] as String,
      firstName: (res['first_name'] ?? '') as String,
      lastName: (res['last_name'] ?? '') as String,
      birthDate: (res['birth_date'] as String?) != null ? DateTime.tryParse(res['birth_date'] as String) : null,
      heightCm: (res['height_cm'] as num?)?.toDouble(),
      weightKg: (res['weight_kg'] as num?)?.toDouble(),
      goal: (res['goal'] ?? '') as String,
    );
  }
}
