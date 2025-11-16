import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_fitness_coach/scr/presentation/state/auth/auth_provider.dart';
import 'package:my_fitness_coach/scr/presentation/theme/style/constant_style_values.dart';
import 'package:my_fitness_coach/scr/presentation/theme/style/styles.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../domain/profile/profile_entity.dart';
import '../../state/profile/profile_onboarding_notifier.dart';
import '../../state/profile/profile_onboarding_state.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstCtrl = TextEditingController();
  final _lastCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _goalCtrl = TextEditingController();
  DateTime? _birth;

  /// Damit wir die Controller nur EINMAL aus dem geladenen Profil befüllen
  bool _initializedFromProfile = false;

  @override
  void initState() {
    super.initState();
    // Profil laden – kein listen, nur einmaliger Aufruf
  }

  @override
  void dispose() {
    _firstCtrl.dispose();
    _lastCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    _goalCtrl.dispose();
    super.dispose();
  }

  String? _validateNotEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validation_required.tr();
    }
    return null;
  }

  String? _validateNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.validation_required.tr();
    }
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null || parsed <= 0) {
      return LocaleKeys.validation_number_invalid.tr();
    }
    return null;
  }

  Future<void> _onSave() async {
    final onboardingState = ref.read(profileOnboardingNotifierProvider);
    final notifier = ref.read(profileOnboardingNotifierProvider.notifier);
    final authState = ref.read(authNotifierProvider);
    final user = authState.user;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No authenticated user')));
      return;
    }

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_birth == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(LocaleKeys.validation_birthdate_required.tr())));
      return;
    }

    final existing = onboardingState.profile;

    final baseProfile =
        existing ??
        Profile(id: user.id, firstName: '', lastName: '', birthDate: null, heightCm: null, weightKg: null, goal: '');

    final updated = baseProfile.copyWith(
      firstName: _firstCtrl.text.trim(),
      lastName: _lastCtrl.text.trim(),
      birthDate: _birth,
      heightCm: double.tryParse(_heightCtrl.text.replaceAll(',', '.')),
      weightKg: double.tryParse(_weightCtrl.text.replaceAll(',', '.')),
      goal: _goalCtrl.text.trim(),
    );

    final success = await notifier.saveProfile(updated);

    if (!success) {
      final msg = ref.read(profileOnboardingNotifierProvider).errorMessage ?? 'Error';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      return;
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(LocaleKeys.profile_saved.tr())));

    // Nach erfolgreichem Onboarding → Home
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileOnboardingNotifierProvider);
    final isSaving = state.status == ProfileOnboardingStatus.saving;

    // Controller EINMALIG aus dem geladenen Profil befüllen
    if (!_initializedFromProfile && state.profile != null) {
      final p = state.profile!;
      _firstCtrl.text = p.firstName;
      _lastCtrl.text = p.lastName;
      _heightCtrl.text = p.heightCm?.toString() ?? '';
      _weightCtrl.text = p.weightKg?.toString() ?? '';
      _goalCtrl.text = p.goal;
      _birth = p.birthDate;
      _initializedFromProfile = true;
    }

    // Initialer Loading-State, bevor wir irgendwas haben
    if (state.status == ProfileOnboardingStatus.loading && !_initializedFromProfile) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.profile_title.tr())),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _firstCtrl,
              decoration: InputDecoration(labelText: LocaleKeys.profile_first_name.tr()),
              validator: _validateNotEmpty,
            ),
            TextFormField(
              controller: _lastCtrl,
              decoration: InputDecoration(labelText: LocaleKeys.profile_last_name.tr()),
              validator: _validateNotEmpty,
            ),
            verticalMargin12,
            Row(
              children: [
                Expanded(
                  child: Text(
                    _birth == null
                        ? LocaleKeys.profile_birth_date_choose.tr()
                        : LocaleKeys.profile_birth_date_label.tr(
                            namedArgs: {'date': _birth!.toLocal().toIso8601String().substring(0, 10)},
                          ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final now = DateTime.now();
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _birth ?? DateTime(now.year - 20),
                      firstDate: DateTime(1900),
                      lastDate: now,
                    );
                    if (picked != null) {
                      setState(() => _birth = picked);
                    }
                  },
                  child: Text(LocaleKeys.profile_date_choose.tr()),
                ),
              ],
            ),
            verticalMargin12,
            TextFormField(
              controller: _heightCtrl,
              decoration: InputDecoration(labelText: LocaleKeys.profile_height.tr()),
              keyboardType: TextInputType.number,
              validator: _validateNumber,
            ),
            TextFormField(
              controller: _weightCtrl,
              decoration: InputDecoration(labelText: LocaleKeys.profile_weight.tr()),
              keyboardType: TextInputType.number,
              validator: _validateNumber,
            ),
            TextFormField(
              controller: _goalCtrl,
              decoration: InputDecoration(labelText: LocaleKeys.profile_goal.tr()),
              validator: _validateNotEmpty,
            ),
            verticalMargin16,
            ElevatedButton(
              onPressed: isSaving ? null : _onSave,
              child: isSaving
                  ? const SizedBox(
                      width: Dimens.TWO_AND_A_HALF,
                      height: Dimens.TWO_AND_A_HALF,
                      child: CircularProgressIndicator(strokeWidth: Dimens.QUARTER),
                    )
                  : Text(LocaleKeys.profile_save.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
