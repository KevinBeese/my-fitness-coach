// scr/presentation/screens/auth/email_verification_screen.dart

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_fitness_coach/generated/locale_keys.g.dart';
import 'package:my_fitness_coach/scr/presentation/state/auth/auth_notifier.dart';
import 'package:my_fitness_coach/scr/presentation/state/auth/auth_provider.dart';
import 'package:my_fitness_coach/scr/presentation/theme/style/styles.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  final String email;
  final String password;

  const EmailVerificationScreen({super.key, required this.email, required this.password});

  @override
  ConsumerState<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends ConsumerState<EmailVerificationScreen> {
  bool _checking = false;
  bool _isVerificationActivated = false;
  int _timer = 0;
  late final AuthNotifier _authNotifier;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _authNotifier = ref.read(authNotifierProvider.notifier);
  }

  Future<void> _checkVerification() async {
    if (_checking) return;

    setState(() => _checking = true);

    await _authNotifier.signIn(widget.email, widget.password);

    if (mounted) setState(() => _checking = false);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

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

                  if (authState.isLoading || _checking) const CircularProgressIndicator(),

                  if (authState.errorMessage != null)
                    Padding(
                      padding: bottomPadding8,
                      child: Text(authState.errorMessage!, style: const TextStyle(color: Colors.red)),
                    ),

                  ElevatedButton(
                    onPressed: (authState.isLoading || _checking || !_isVerificationActivated)
                        ? null
                        : _checkVerification,
                    child: Text(
                      LocaleKeys.auth_check_email_button.tr(
                        namedArgs: {'timer': _isVerificationActivated ? '' : '(${10 - _timer})'},
                      ),
                    ),
                  ),

                  TextButton(onPressed: () => _authNotifier.signOut(), child: Text(LocaleKeys.auth_back_to_login.tr())),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _startTimer() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      setState(() {
        _timer += 1;
      });
      if (_timer >= 10 && !_isVerificationActivated) {
        _isVerificationActivated = true;
      }
    }
  }
}
