// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import '../../domain/profile/profile_entity.dart';
// import '../../domain/profile/profile_repository.dart';
// import 'profile_api.dart';

// /// Provider für das Repository
// final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
//   final client = Supabase.instance.client;
//   final api = ProfileApi(client);
//   return ProfileRepositoryImpl(api, client);
// });

// class ProfileRepositoryImpl implements ProfileRepository {
//   final ProfileApi _api;
//   final SupabaseClient _client;

//   ProfileRepositoryImpl(this._api, this._client);

//   @override
//   Future<Profile?> fetchProfile(String userId) async {
//     final user = _client.auth.currentUser;
//     if (user == null) return null;
//     return _api.fetchProfileForUser(user.id);
//   }

//   @override
//   Future<Profile> upsertProfile(Profile profile) async {
//     return _api.upsertProfile(profile);
//   }

//   @override
//   Future<Profile> updateTrainingPreferences({
//     required String profileId,
//     required List<String> trainingDays,
//     required int weeklyTrainingMinutes,
//   }) async {
//     return _api.updateTrainingPreferences(
//       profileId: profileId,
//       trainingDays: trainingDays,
//       weeklyTrainingMinutes: weeklyTrainingMinutes,
//     );
//   }
// }
