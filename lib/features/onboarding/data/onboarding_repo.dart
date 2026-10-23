import 'package:dio/dio.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_exceptions.dart';
import 'models/onboarding_slide.dart';

class OnboardingRepo {
  OnboardingRepo({required DioClient dio}) : _dio = dio;

  final DioClient _dio;

  Future<List<OnboardingSlide>> getSlides() async {
    try {
      final response = await _dio.get(ApiEndpoints.splash);
      final data = response.data['data'];
      final items = data is List ? data : [data];
      return items
          .whereType<Map<String, dynamic>>()
          .map(OnboardingSlide.fromJson)
          .where((slide) => slide.title.trim().isNotEmpty)
          .toList();
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }
}
