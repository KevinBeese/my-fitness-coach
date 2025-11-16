import 'package:supabase_flutter/supabase_flutter.dart';

/// Abstraktes Interface – Presentation kennt NUR dieses Interface.
abstract class IAuthRepository {
  /// Login mit E-Mail & Passwort.
  Future<Session> signIn({required String email, required String password});

  /// Registrierung mit E-Mail & Passwort.
  Future<User> signUp({required String email, required String password});

  /// Logout.
  Future<void> signOut();

  /// Aktuelle Session (falls vorhanden).
  Session? get currentSession;

  /// Aktueller User (falls vorhanden).
  User? get currentUser;

  /// Stream für Auth-Änderungen (optional, aber praktisch für AuthGate).
  Stream<Session?> authChanges();
}
