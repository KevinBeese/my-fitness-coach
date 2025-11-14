import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/auth/auth_repository.dart';
import '../../domain/auth/user_entity.dart';
import 'auth_api.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _api;

  AuthRepositoryImpl(this._api);

  AppUser? _mapUser(User? user) {
    if (user == null) return null;
    return AppUser(id: user.id, email: user.email ?? '');
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final u = _api.currentUser;
    return _mapUser(u);
  }

  @override
  Stream<AppUser?> authStateChanges() {
    return _api.authStateStream.map((event) => _mapUser(event.session?.user));
  }

  @override
  Future<AppUser> signInWithEmailPassword({required String email, required String password}) async {
    final res = await _api.signIn(email: email, password: password);
    final user = res.user;
    if (user == null) {
      throw Exception('No user returned from signIn');
    }
    return _mapUser(user)!;
  }

  @override
  Future<AppUser> signUpWithEmailPassword({required String email, required String password}) async {
    final res = await _api.signUp(email: email, password: password);
    final user = res.user;
    if (user == null) {
      throw Exception('No user returned from signUp');
    }
    return _mapUser(user)!;
  }

  @override
  Future<void> signOut() {
    return _api.signOut();
  }
}
