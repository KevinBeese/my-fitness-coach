// lib/scr/data/auth/supabase_auth_repository.dart
import 'package:my_fitness_coach/exports.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/auth/i_auth_repository.dart';

class SupabaseAuthRepository implements IAuthRepository {
  final SupabaseClient _client;

  SupabaseAuthRepository(this._client);

  @override
  Future<Session> signIn({required String email, required String password}) async {
    final response = await _client.auth.signInWithPassword(email: email, password: password);

    final session = response.session;
    if (session == null) {
      throw AuthException(LocaleKeys.auth_login_error.tr());
    }

    return session;
  }

  @override
  Future<User> signUp({required String email, required String password}) async {
    final response = await _client.auth.signUp(email: email, password: password);

    final user = response.user;
    if (user == null) {
      throw AuthException(LocaleKeys.auth_register_error.tr());
    }

    return user;
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  Session? get currentSession => _client.auth.currentSession;

  @override
  User? get currentUser => _client.auth.currentUser;

  @override
  Stream<Session?> authChanges() {
    return _client.auth.onAuthStateChange.map((event) => event.session);
  }
}
