import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_fitness_coach/generated/locale_keys.g.dart';
import 'package:my_fitness_coach/scr/auth/auth_state_notifier.dart';
import 'package:my_fitness_coach/scr/core/constants.dart';
import 'package:my_fitness_coach/scr/presentation/app/routes/app_routes.dart';
import 'package:my_fitness_coach/scr/presentation/theme/style/styles.dart';

class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({super.key});
  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isSignUp = false;

  Future<void> _submit() async {
    final notifier = ref.read(authStateNotifierProvider.notifier);
    final email = _email.text.trim().isEmpty ? Constants.defaultAppUser : _email.text.trim();
    final password = _password.text.trim().isEmpty ? Constants.defaultAppUserPassword : _password.text.trim();

    if (_isSignUp) {
      await notifier.signUp(email, password);
      final state = ref.read(authStateNotifierProvider);
      if (state.error == null && mounted && state.user != null) {
        // Registrierung erfolgreich → Waiting Screen
        Navigator.of(context).pushNamed(AppRoutes.verifyEmail, arguments: {'email': email, 'password': password});
        return;
      }
    } else {
      await notifier.signIn(email, password);
      final state = ref.read(authStateNotifierProvider);
      if (state.session != null && mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        return;
      }
    }

    final error = ref.read(authStateNotifierProvider).error;
    if (error != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateNotifierProvider);
    final notifier = ref.read(authStateNotifierProvider.notifier);
    if (authState.session != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.app_title.tr()),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await notifier.signOut();
              },
            ),
          ],
        ),
        body: Center(child: Text(LocaleKeys.dashboard_home.tr())),
      );
    }
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Card(
            child: Padding(
              padding: allPadding16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isSignUp ? LocaleKeys.auth_create_account.tr() : LocaleKeys.auth_sign_in.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  verticalMargin12,
                  TextField(
                    controller: _email,
                    decoration: InputDecoration(labelText: LocaleKeys.auth_email.tr()),
                  ),
                  TextField(
                    controller: _password,
                    decoration: InputDecoration(labelText: LocaleKeys.auth_password.tr()),
                    obscureText: true,
                  ),
                  verticalMargin12,
                  if (authState.isLoading) const CircularProgressIndicator(),
                  if (authState.error != null)
                    Padding(
                      padding: bottomPadding8,
                      child: Text(authState.error!, style: const TextStyle(color: Colors.red)),
                    ),
                  ElevatedButton(
                    onPressed: authState.isLoading ? null : _submit,
                    child: Text(_isSignUp ? LocaleKeys.auth_register.tr() : LocaleKeys.auth_login.tr()),
                  ),
                  TextButton(
                    onPressed: authState.isLoading ? null : () => setState(() => _isSignUp = !_isSignUp),
                    child: Text(_isSignUp ? LocaleKeys.auth_already_account.tr() : LocaleKeys.auth_no_account.tr()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
