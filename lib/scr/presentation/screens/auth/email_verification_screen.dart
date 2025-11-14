// scr/presentation/screens/auth/email_verification_screen.dart

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_fitness_coach/generated/locale_keys.g.dart';
import 'package:my_fitness_coach/scr/auth/auth_state_notifier.dart';
import 'package:my_fitness_coach/scr/presentation/app/routes/app_routes.dart';
import 'package:my_fitness_coach/scr/presentation/theme/style/styles.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  final String email;
  final String password;

  const EmailVerificationScreen({super.key, required this.email, required this.password});

  @override
  ConsumerState<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends ConsumerState<EmailVerificationScreen> {
  Timer? _timer;
  bool _checking = false;

  @override
  void initState() {
    super.initState();
    // alle 5 Sekunden versuchen wir, den User einzuloggen
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => _checkVerification());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _checkVerification() async {
    if (!mounted || _checking) return;

    _checking = true;
    final notifier = ref.read(authStateNotifierProvider.notifier);

    await notifier.signIn(widget.email, widget.password);

    final authState = ref.read(authStateNotifierProvider);
    _checking = false;

    if (!mounted) return;

    if (authState.session != null) {
      _timer?.cancel();
      Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateNotifierProvider);

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
                  Text(LocaleKeys.auth_check_email_title.tr(), style: Theme.of(context).textTheme.headlineSmall),
                  verticalMargin12,
                  Text(
                    LocaleKeys.auth_check_email_message.tr(namedArgs: {'email': widget.email}),
                    textAlign: TextAlign.center,
                  ),
                  verticalMargin12,
                  if (authState.isLoading) const CircularProgressIndicator(),
                  if (authState.error != null)
                    Padding(
                      padding: bottomPadding8,
                      child: Text(authState.error!, style: const TextStyle(color: Colors.red)),
                    ),
                  ElevatedButton(
                    onPressed: authState.isLoading ? null : _checkVerification,
                    child: Text(LocaleKeys.auth_check_email_button.tr()),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(LocaleKeys.auth_back_to_login.tr()),
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
