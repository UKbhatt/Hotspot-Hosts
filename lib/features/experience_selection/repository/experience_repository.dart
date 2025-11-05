import 'package:dio/dio.dart';
import '../../../core/api/dio_client.dart';
import '../../../core/models/experience_model.dart';

class ExperienceRepository {
  final DioClient dioClient;
  ExperienceRepository(this.dioClient);

  Future<List<Experience>> getExperiences() async {
    try {
      final res = await dioClient.dio.get('experiences?active=true');
      final list = res.data['data']['experiences'] as List;
      return list.map((e) => Experience.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
