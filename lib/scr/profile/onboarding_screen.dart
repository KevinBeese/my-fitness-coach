import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _first = TextEditingController();
  final _last = TextEditingController();
  DateTime? _birth;
  final _height = TextEditingController();
  final _weight = TextEditingController();
  final _goal = TextEditingController();
  bool _loading = false;

  Future<void> _save() async {
    final client = Supabase.instance.client;
    final user = client.auth.currentUser;
    if (user == null) return;
    setState(() => _loading = true);
    try {
      await client.from('profiles').upsert({
        'id': user.id,
        'email': user.email,
        'first_name': _first.text.trim(),
        'last_name': _last.text.trim(),
        'birth_date': _birth?.toIso8601String(),
        'height_cm': int.tryParse(_height.text),
        'weight_kg': double.tryParse(_weight.text),
        'goal': _goal.text.trim(),
      });
      if (mounted) Navigator.of(context).pop();
    } on PostgrestException catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil anlegen')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextField(
                controller: _first,
                decoration: const InputDecoration(labelText: 'Vorname'),
              ),
              TextField(
                controller: _last,
                decoration: const InputDecoration(labelText: 'Nachname'),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _birth == null
                          ? 'Geburtsdatum auswählen'
                          : 'Geburtsdatum: ${_birth!.toLocal().toIso8601String().substring(0, 10)}',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final now = DateTime.now();
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime(now.year - 20),
                        firstDate: DateTime(1900),
                        lastDate: now,
                      );
                      if (picked != null) setState(() => _birth = picked);
                    },
                    child: const Text('Datum wählen'),
                  ),
                ],
              ),
              TextField(
                controller: _height,
                decoration: const InputDecoration(labelText: 'Größe (cm)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _weight,
                decoration: const InputDecoration(labelText: 'Gewicht (kg)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _goal,
                decoration: const InputDecoration(labelText: 'Persönliches Ziel'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _loading ? null : _save, child: Text(_loading ? 'Speichert…' : 'Speichern')),
            ],
          ),
        ),
      ),
    );
  }
}
