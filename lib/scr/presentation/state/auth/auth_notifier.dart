import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

import '../../../data/auth/auth_api.dart';
import '../../../data/auth/auth_repository_impl.dart';
import '../../../domain/auth/auth_repository.dart';
import '../../../domain/auth/user_entity.dart';
import 'auth_state.dart';

// Repository-Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = Supabase.instance.client;
  final api = AuthApi(client);
  return AuthRepositoryImpl(api);
});

// StateNotifierProvider
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  final notifier = AuthNotifier(repo);

  // auth state stream abonnieren
  repo.authStateChanges().listen((user) {
    notifier._onAuthChanged(user);
  });

  // Beim Start einmal den aktuellen User prüfen
  notifier.checkAuthOnStart();

  return notifier;
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState());

  Future<void> checkAuthOnStart() async {
    state = state.copyWith(status: AuthStatus.loading);
    final user = await _repository.getCurrentUser();
    if (user != null) {
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } else {
      state = state.copyWith(status: AuthStatus.unauthenticated, user: null);
    }
  }

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      final user = await _repository.signInWithEmailPassword(email: email, password: password);
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, errorMessage: e.toString(), user: null);
    }
  }

  Future<void> signUp(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      final user = await _repository.signUpWithEmailPassword(email: email, password: password);
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, errorMessage: e.toString(), user: null);
    }
  }

  Future<void> signOut() async {
    await _repository.signOut();
    state = state.copyWith(status: AuthStatus.unauthenticated, user: null);
  }

  void _onAuthChanged(AppUser? user) {
    if (user == null) {
      state = state.copyWith(status: AuthStatus.unauthenticated, user: null);
    } else {
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    }
  }
}
