// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> _de = {
    "app_title": "Mein Fitness Coach",
    "home": {"welcome": "Willkommen, {name}!", "start_training": "Training starten"},
    "profile": {
      "title": "Profil",
      "create": "Profil anlegen",
      "first_name": "Vorname",
      "last_name": "Nachname",
      "birth_date_choose": "Geburtsdatum wählen",
      "birth_date_select": "Geburtsdatum auswählen",
      "birth_date_label": "Geburtsdatum: {date}",
      "date_choose": "Datum wählen",
      "height": "Größe (cm)",
      "weight": "Gewicht (kg)",
      "goal": "Ziel",
      "personal_goal": "Persönliches Ziel",
      "save": "Speichern",
      "saving": "Speichert…",
      "saved": "Profil gespeichert.",
    },
    "auth": {
      "create_account": "Konto erstellen",
      "sign_in": "Anmelden",
      "email": "E‑Mail",
      "password": "Passwort",
      "login": {
        "title": "Login zum Konto",
        "button": "Einloggen",
        "error": "Login fehlgeschlagen. Keine Session erhalten",
      },
      "already_account": "Schon ein Konto? Anmelden",
      "no_account": "Noch kein Konto? Registrieren",
      "register": {
        "title": "Konto erstellen",
        "button": "Registrieren",
        "error": "Registrierung fehlgeschlagen. Kein User erhalten",
      },
      "check_email": {
        "title": "E‑Mail bestätigen",
        "message":
            "Wir haben eine Bestätigungs-E‑Mail an {email} gesendet. Bitte überprüfe deinen Posteingang und klicke auf den Bestätigungslink, um dein Konto zu aktivieren.\n\n Bitte überprüfe auch deinen Spam-Ordner, falls du die E‑Mail nicht in deinem Posteingang findest. \n\n Erst danach kannst du dich einloggen.",
        "button": "E‑Mail bestätigt? Weiter zum Login {timer}",
      },
      "back_to_login": "Zurück zum Login",
    },
    "dashboard": {"home": "Home 🏋️ (später Dashboard)"},
    "validation": {
      "required": "Dieses Feld ist erforderlich.",
      "number_invalid": "Ungültige Zahl.",
      "birthdate_required": "Geburtsdatum ist erforderlich.",
    },
  };
  static const Map<String, dynamic> _en = {
    "app_title": "My Fitness Coach",
    "home": {"welcome": "Welcome, {name}!", "start_training": "Start training"},
    "profile": {
      "title": "Profile",
      "create": "Create profile",
      "first_name": "First name",
      "last_name": "Last name",
      "birth_date_choose": "Select birth date",
      "birth_date_select": "Choose birth date",
      "birth_date_label": "Birth date: {date}",
      "date_choose": "Choose date",
      "height": "Height (cm)",
      "weight": "Weight (kg)",
      "goal": "Goal",
      "personal_goal": "Personal goal",
      "save": "Save",
      "saving": "Saving…",
      "saved": "Profile saved.",
    },
    "auth": {
      "create_account": "Create account",
      "sign_in": "Sign in",
      "email": "Email",
      "password": "Password",
      "login": {"title": "Login to your account", "button": "Log in", "error": "Login failed. No session received"},
      "register": {
        "title": "Register",
        "button": "Create an account",
        "error": "Registration failed. No user received",
      },
      "already_account": "Already have an account? Sign in",
      "no_account": "No account yet? Register",
      "login_title": "Login to your account",
      "login_button": "Log in",
      "check_email": {
        "title": "Verify Email",
        "message":
            "We have sent a verification email to {email}. Please check your inbox and click the verification link to activate your account.\n\n Please also check your spam folder if you don't find the email in your inbox. \n\n Only then can you log in.",
        "button": "Email verified? Proceed to Login {timer}",
      },
      "back_to_login": "Back to Login",
    },
    "dashboard": {"home": "Home 🏋️ (dashboard later)"},
    "validation": {
      "required": "This field is required.",
      "number_invalid": "Number is invalid.",
      "birthdate_required": "Birthdate is required.",
    },
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {"de": _de, "en": _en};
}
