import 'package:supabase_flutter/supabase_flutter.dart';

enum AuthStatus { unknown, loading, unauthenticated, authenticated, error }

class AuthState {
  final AuthStatus status;
  final bool isLoading;
  final User? user;
  final Session? session;
  final String? email;
  final String? password;
  final String? errorMessage;

  const AuthState({
    required this.status,
    this.isLoading = false,
    this.user,
    this.session,
    this.email,
    this.password,
    this.errorMessage,
  });

  factory AuthState.unknown() => const AuthState(status: AuthStatus.unknown, isLoading: false);

  factory AuthState.loading() => const AuthState(status: AuthStatus.loading, isLoading: true);

  factory AuthState.unauthenticated() => const AuthState(status: AuthStatus.unauthenticated, isLoading: false);

  factory AuthState.authenticated(Session session) =>
      AuthState(status: AuthStatus.authenticated, user: session.user, session: session, isLoading: false);

  factory AuthState.error(String errorMessage) =>
      AuthState(status: AuthStatus.error, errorMessage: errorMessage, isLoading: false);

  AuthState copyWith({
    AuthStatus? status,
    bool? isLoading,
    User? user,
    Session? session,
    String? email,
    String? password,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      session: session ?? this.session,
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
