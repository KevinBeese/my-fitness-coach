// // lib/scr/presentation/state/profile/profile_providers.dart
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:hooks_riverpod/legacy.dart';
// import 'package:my_fitness_coach/scr/domain/profile/profile_entity.dart';
// import 'package:my_fitness_coach/scr/domain/profile/profile_repository.dart';
// import 'package:my_fitness_coach/scr/domain/profile/supabase_profile_repository.dart';
// import 'package:my_fitness_coach/scr/presentation/state/auth/auth_provider.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import 'profile_notifier.dart';

// final profileRepositoryProvider = Provider<IProfileRepository>((ref) {
//   final client = Supabase.instance.client;
//   return SupabaseProfileRepository(client);
// });

// final profileNotifierProvider = StateNotifierProvider<ProfileNotifier, AsyncValue<Profile?>>((ref) {
//   final repo = ref.watch(profileRepositoryProvider);
//   final authRepo = ref.watch(authRepositoryProvider);
//   final userId = authRepo.currentUser?.id;
//   return ProfileNotifier(repo, userId: userId);
// });
