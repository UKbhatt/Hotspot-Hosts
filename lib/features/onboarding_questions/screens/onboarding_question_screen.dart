import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/onboarding_provider.dart';
import '../widgets/audio_recorder_widget.dart';
import '../widgets/video_recorder_widget.dart';

class OnboardingQuestionScreen extends ConsumerWidget {
  const OnboardingQuestionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = ref.watch(questionTextProvider);
    final audio = ref.watch(audioPathProvider);
    final video = ref.watch(videoPathProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding Questions')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              maxLength: 600,
              maxLines: 6,
              onChanged: (value) =>
                  ref.read(questionTextProvider.notifier).state = value,
              decoration: const InputDecoration(
                hintText: 'Why do you want to be a Hotspot Host?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            if (audio == null)
              AudioRecorderWidget(
                onRecorded: (path) =>
                    ref.read(audioPathProvider.notifier).state = path,
              )
            else
              ListTile(
                title: const Text('Audio Recorded'),
                subtitle: Text(audio),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () =>
                      ref.read(audioPathProvider.notifier).state = null,
                ),
              ),
            const SizedBox(height: 16),
            if (video == null)
              VideoRecorderWidget(
                onRecorded: (path) =>
                    ref.read(videoPathProvider.notifier).state = path,
              )
            else
              ListTile(
                title: const Text('Video Recorded'),
                subtitle: Text(video),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () =>
                      ref.read(videoPathProvider.notifier).state = null,
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                debugPrint('Text: $text');
                debugPrint('Audio: $audio');
                debugPrint('Video: $video');
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
