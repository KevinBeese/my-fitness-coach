import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../profile/onboarding_screen.dart';

final sessionProvider = StateProvider<Session?>((ref) => Supabase.instance.client.auth.currentSession);

class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({super.key});
  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isSignUp = false;

  @override
  void initState() {
    super.initState();
    Supabase.instance.client.auth.onAuthStateChange.listen((event) {
      ref.read(sessionProvider.notifier).state = event.session;
      setState(() {});
    });
  }

  Future<void> _submit() async {
    final supa = Supabase.instance.client;
    try {
      if (_isSignUp) {
        final res = await supa.auth.signUp(email: _email.text.trim(), password: _password.text);
        if (res.user != null) {
          // nach SignUp zum Onboarding
          if (mounted)
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const OnboardingScreen()));
        }
      } else {
        await supa.auth.signInWithPassword(email: _email.text.trim(), password: _password.text);
      }
    } on AuthException catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);
    if (session != null) {
      return const Scaffold(body: Center(child: Text('Home 🏋️ (später Dashboard)')));
    }
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_isSignUp ? 'Konto erstellen' : 'Anmelden', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _email,
                    decoration: const InputDecoration(labelText: 'E‑Mail'),
                  ),
                  TextField(
                    controller: _password,
                    decoration: const InputDecoration(labelText: 'Passwort'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(onPressed: _submit, child: Text(_isSignUp ? 'Registrieren' : 'Login')),
                  TextButton(
                    onPressed: () => setState(() => _isSignUp = !_isSignUp),
                    child: Text(_isSignUp ? 'Schon ein Konto? Anmelden' : 'Noch kein Konto? Registrieren'),
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
