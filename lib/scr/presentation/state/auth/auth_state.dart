import '../../../domain/auth/user_entity.dart';

enum AuthStatus { unknown, authenticated, unauthenticated, loading, error }

class AuthState {
  final AuthStatus status;
  final AppUser? user;
  final String? errorMessage;

  const AuthState({this.status = AuthStatus.unknown, this.user, this.errorMessage});

  AuthState copyWith({AuthStatus? status, AppUser? user, String? errorMessage}) {
    return AuthState(status: status ?? this.status, user: user ?? this.user, errorMessage: errorMessage);
  }
}
