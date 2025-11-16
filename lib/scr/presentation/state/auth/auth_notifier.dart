// lib/scr/presentation/state/auth/auth_notifier.dart
import 'package:hooks_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

import '../../../domain/auth/i_auth_repository.dart';
import 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final IAuthRepository _repo;

  AuthNotifier(this._repo)
    : super(_repo.currentSession != null ? AuthState.authenticated(_repo.currentSession!) : AuthState.unknown()) {
    // Optional: auf Auth-Änderungen hören
    _repo.authChanges().listen(_onAuthChanged);
  }

  void _onAuthChanged(Session? session) {
    if (session == null) {
      state = AuthState.unknown();
    } else if (session.user.emailConfirmedAt == null) {
      state = state.copyWith(status: AuthStatus.unauthenticated);
    } else {
      state = AuthState.authenticated(session);
    }
  }

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading, isLoading: true, errorMessage: null);

    try {
      final session = await _repo.signIn(email: email, password: password);
      if (session.user.emailConfirmedAt == null) {
        state = state.copyWith(status: AuthStatus.unauthenticated, isLoading: false);
        return;
      } else {
        state = AuthState.authenticated(session);
      }
    } on AuthException catch (e) {
      state = state.copyWith(status: AuthStatus.error, isLoading: false, errorMessage: e.message);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> signUp(String email, String password) async {
    state = state.copyWith(
      status: AuthStatus.loading,
      isLoading: true,
      errorMessage: null,
      email: email,
      password: password,
    );

    try {
      final result = await _repo.signUp(email: email, password: password);

      if (result.emailConfirmedAt == null) {
        // Viele Flows: Nach Registrierung bleibt man unauthenticated
        // bis E-Mail bestätigt ist → hier z. B.:
        state = state.copyWith(status: AuthStatus.unauthenticated, isLoading: false);
      } else {
        await signIn(email, password);
      }
    } on AuthException catch (e) {
      state = state.copyWith(status: AuthStatus.error, isLoading: false, errorMessage: e.message);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> verificationAccepted() async {
    state = state.copyWith(status: AuthStatus.loading, isLoading: true, errorMessage: null);

    try {
      await signIn(state.user!.email!, state.password!);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(status: AuthStatus.loading, isLoading: true, errorMessage: null);

    try {
      await _repo.signOut();
      state = state.copyWith(status: AuthStatus.unknown, isLoading: false);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, isLoading: false, errorMessage: e.toString());
    }
  }
}
