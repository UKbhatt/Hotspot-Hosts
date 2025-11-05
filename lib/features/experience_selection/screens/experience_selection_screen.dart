import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hotspot_hosts/features/experience_selection/widgets/experience_card.dart';
import '../provider/experience_provider.dart';
import '../widgets/experience_card.dart';
import '../widgets/text_input_field.dart';

class ExperienceSelectionScreen extends ConsumerWidget {
  const ExperienceSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final experiences = ref.watch(experienceListProvider);
    final selected = ref.watch(selectedExperiencesProvider);
    final text = ref.watch(userTextProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Select Experiences')),
      body: experiences.when(
        data: (data) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ...data.map(
              (exp) => ExperienceCard(
                experience: exp,
                isSelected: selected.contains(exp.id),
                onTap: () {
                  final current = [...selected];
                  current.contains(exp.id)
                      ? current.remove(exp.id)
                      : current.add(exp.id);
                  ref.read(selectedExperiencesProvider.notifier).state = current;
                },
              ),
            ),
            const SizedBox(height: 20),
            TextInputField(
              hint: 'Tell us about your experience...',
              maxLength: 250,
              onChanged: (value) =>
                  ref.read(userTextProvider.notifier).state = value,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                debugPrint('Selected IDs: $selected');
                debugPrint('User Text: ${text.isEmpty ? "N/A" : text}');
                context.go('/onboarding');
              },
              child: const Text('Next'),
            ),
          ],
        ),
        error: (e, _) => Center(child: Text('Error: $e')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
