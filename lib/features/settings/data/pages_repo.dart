import 'package:dio/dio.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_exceptions.dart';
import 'models/remote_page.dart';

class PagesRepo {
  PagesRepo({required DioClient dio}) : _dio = dio;

  final DioClient _dio;

  Future<RemotePage?> getPage(String slug) async {
    try {
      final response = await _dio.get(ApiEndpoints.pages);
      final data = response.data['data'] as List<dynamic>? ?? const [];
      return data
          .whereType<Map<String, dynamic>>()
          .map(RemotePage.fromJson)
          .where((page) => page.slug == slug)
          .firstOrNull;
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }
}
