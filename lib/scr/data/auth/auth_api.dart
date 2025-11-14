import 'package:supabase_flutter/supabase_flutter.dart';

class AuthApi {
  final SupabaseClient client;

  AuthApi(this.client);

  Future<AuthResponse> signIn({required String email, required String password}) {
    return client.auth.signInWithPassword(email: email, password: password);
  }

  Future<AuthResponse> signUp({required String email, required String password}) {
    return client.auth.signUp(email: email, password: password);
  }

  User? get currentUser => client.auth.currentUser;

  Stream<AuthState> get authStateStream => client.auth.onAuthStateChange;

  Future<void> signOut() => client.auth.signOut();
}
