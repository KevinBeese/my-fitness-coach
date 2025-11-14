// scr/auth/auth_state_notifier.dart
import 'package:hooks_riverpod/legacy.dart';
import 'package:my_fitness_coach/scr/core/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final User? user;
  final Session? session;

  AuthState({this.isLoading = false, this.error, this.user, this.session});

  AuthState copyWith({bool? isLoading, String? error, User? user, Session? session}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      user: user ?? this.user,
      session: session ?? this.session,
    );
  }
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier() : super(AuthState(session: Supabase.instance.client.auth.currentSession));

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final signInResponse = await Supabase.instance.client.auth.signInWithPassword(
        email: email.isEmpty ? Constants.defaultAppUser : email,
        password: password.isEmpty ? Constants.defaultAppUserPassword : password,
      );
      state = state.copyWith(isLoading: false, error: null, session: signInResponse.session, user: signInResponse.user);
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message, session: null);
    }
  }

  Future<void> signUp(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null, session: null);
    try {
      final signUpResponse = await Supabase.instance.client.auth.signUp(email: email, password: password);
      if (signUpResponse.session != null) {
        state = state.copyWith(isLoading: false, error: null, session: signUpResponse.session);
      } else if (signUpResponse.user != null) {
        // Bei Email-Verification ist hier i.d.R. KEINE Session vorhanden.
        // Wichtig ist: kein Fehler ⇒ Registrierung ok.
        state = state.copyWith(
          isLoading: false,
          error: null,
          user: signUpResponse.user,
          session: signUpResponse.session,
        );
      }
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message, session: null);
    }
  }

  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
    state = state.copyWith(session: null);
  }
}

final authStateNotifierProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) => AuthStateNotifier());
