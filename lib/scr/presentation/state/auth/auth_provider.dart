// lib/scr/presentation/state/auth/auth_providers.dart
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

import '../../../data/auth/supabase_auth_repository.dart';
import '../../../domain/auth/i_auth_repository.dart';
import 'auth_notifier.dart';
import 'auth_state.dart';

/// Repository-Provider – Presentation kennt nur das Interface.
final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final client = Supabase.instance.client;
  return SupabaseAuthRepository(client);
});

/// AuthNotifier-Provider
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AuthNotifier(repo);
});
