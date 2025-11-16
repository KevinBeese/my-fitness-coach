import 'package:my_fitness_coach/scr/domain/profile/profile_entity.dart';
import 'package:my_fitness_coach/scr/domain/profile/profile_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProfileRepository implements ProfileRepository {
  final SupabaseClient _client;

  SupabaseProfileRepository(this._client);

  @override
  Future<Profile?> fetchProfile(String userId) async {
    final data = await _client.from('profiles').select().eq('id', userId).maybeSingle();

    if (data == null) return null;

    return Profile(
      id: data['id'] as String,
      firstName: data['first_name'] as String? ?? '',
      lastName: data['last_name'] as String? ?? '',
      birthDate: data['birth_date'] != null ? DateTime.parse(data['birth_date'] as String) : null,
      heightCm: (data['height_cm'] as num?)?.toDouble(),
      weightKg: (data['weight_kg'] as num?)?.toDouble(),
      goal: data['goal'] as String? ?? '',
    );
  }

  @override
  Future<Profile> upsertProfile(Profile profile) async {
    final map = <String, dynamic>{
      'id': profile.id,
      'first_name': profile.firstName,
      'last_name': profile.lastName,
      'birth_date': profile.birthDate?.toIso8601String(),
      'height_cm': profile.heightCm,
      'weight_kg': profile.weightKg,
      'goal': profile.goal,
    };

    final data = await _client.from('profiles').upsert(map).select().single();

    return Profile(
      id: data['id'] as String,
      firstName: data['first_name'] as String? ?? '',
      lastName: data['last_name'] as String? ?? '',
      birthDate: data['birth_date'] != null ? DateTime.parse(data['birth_date'] as String) : null,
      heightCm: (data['height_cm'] as num?)?.toDouble(),
      weightKg: (data['weight_kg'] as num?)?.toDouble(),
      goal: data['goal'] as String? ?? '',
    );
  }
}
