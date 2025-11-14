import 'user_entity.dart';

abstract class AuthRepository {
  Future<AppUser?> getCurrentUser();
  Stream<AppUser?> authStateChanges();

  Future<AppUser> signInWithEmailPassword({required String email, required String password});

  Future<AppUser> signUpWithEmailPassword({required String email, required String password});

  Future<void> signOut();
}
