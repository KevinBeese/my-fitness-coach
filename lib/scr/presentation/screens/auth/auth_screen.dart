import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_fitness_coach/scr/core/constants.dart';
import 'package:my_fitness_coach/scr/presentation/theme/style/styles.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../state/auth/auth_notifier.dart';
import '../../state/auth/auth_state.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailCtrl = useTextEditingController(text: Constants.defaultAppUser);
    final passwordCtrl = useTextEditingController(text: Constants.defaultAppUserPassword);
    final state = ref.watch(authNotifierProvider);
    final notifier = ref.read(authNotifierProvider.notifier);

    Future<void> onLogin() async {
      await notifier.signIn(emailCtrl.text.trim(), passwordCtrl.text.trim());
      if (state.status == AuthStatus.error && state.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
      }
    }

    Future<void> onSignUp() async {
      await notifier.signUp(emailCtrl.text.trim(), passwordCtrl.text.trim());
      if (state.status == AuthStatus.error && state.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
      }
    }

    final isLoading = state.status == AuthStatus.loading;

    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.auth_login_title.tr())),
      body: Padding(
        padding: allPadding16,
        child: Column(
          children: [
            TextField(
              controller: emailCtrl,
              decoration: InputDecoration(labelText: LocaleKeys.auth_email.tr()),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordCtrl,
              decoration: InputDecoration(labelText: LocaleKeys.auth_password.tr()),
              obscureText: true,
            ),
            verticalMargin16,
            if (state.status == AuthStatus.error && state.errorMessage != null) ...[
              Text(state.errorMessage!, style: const TextStyle(color: Colors.red)),
              verticalMargin8,
            ],
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: isLoading ? null : onLogin,
                    child: isLoading ? const CircularProgressIndicator() : Text(LocaleKeys.auth_login_button.tr()),
                  ),
                ),
                horizontalMargin16,
                Expanded(
                  child: OutlinedButton(
                    onPressed: isLoading ? null : onSignUp,
                    child: Text(LocaleKeys.auth_register_button.tr()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
