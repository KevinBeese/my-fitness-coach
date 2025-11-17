// lib/scr/presentation/training/training_preferences_screen.dart

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_fitness_coach/scr/domain/profile/profile_entity.dart';
import 'package:my_fitness_coach/scr/presentation/state/profile/training/training_preferences_notifier.dart';
import 'package:my_fitness_coach/scr/presentation/theme/style/styles.dart';

class TrainingPreferencesScreen extends ConsumerWidget {
  const TrainingPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(trainingPreferencesProvider);
    final notifier = ref.read(trainingPreferencesProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Trainingseinstellungen')),
      body: SafeArea(
        child: Padding(
          padding: allPadding16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Abschnitt: Trainingstage
              Text('An welchen Tagen möchtest du trainieren?', style: Theme.of(context).textTheme.titleMedium),
              verticalMargin12,
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: TrainingDay.values.map((day) {
                  final isSelected = state.selectedDays?.contains(day) == true;
                  return FilterChip(
                    label: Text(day.name), // dein enum-Getter mit .tr()
                    selected: isSelected,
                    onSelected: (_) => notifier.toggleDay(day),
                  );
                }).toList(),
              ),
              verticalMargin24,

              // Abschnitt: Wöchentliche Zeit
              Text(
                'Wie viel Zeit pro Woche möchtest du fürs Training einplanen?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              verticalMargin12,
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      min: 0,
                      max: MAX_TRAINING_HOURS_PER_WEEK.toDouble(),
                      value: state.weeklyTrainingHours?.toDouble() ?? 0,
                      onChanged: (value) => notifier.setWeeklyTrainingHours(value.round()),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(width: 70, child: Text('${state.weeklyTrainingHours} h', textAlign: TextAlign.right)),
                ],
              ),
              verticalMargin8,

              const Spacer(),

              // Speichern-Button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: state.isSaving
                      ? null
                      : () async {
                          await notifier.save();
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        },
                  child: state.isSaving
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Speichern'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
