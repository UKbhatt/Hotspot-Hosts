import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/dio_client.dart';
import '../repository/experience_repository.dart';
import '../../../core/models/experience_model.dart';
import 'package:riverpod/legacy.dart';

final experienceRepoProvider = Provider(
  (ref) => ExperienceRepository(DioClient()),
);

final experienceListProvider = FutureProvider<List<Experience>>((ref) async {
  final repo = ref.watch(experienceRepoProvider);
  return repo.getExperiences();
});

final selectedExperiencesProvider =
    StateProvider<List<int>>((ref) => []);

final userTextProvider = StateProvider<String>((ref) => '');
