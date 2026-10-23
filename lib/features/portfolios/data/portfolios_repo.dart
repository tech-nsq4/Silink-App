import 'package:dio/dio.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_exceptions.dart';
import 'models/portfolio_model.dart';

class PortfoliosRepo {
  PortfoliosRepo({required DioClient dio}) : _dio = dio;

  final DioClient _dio;

  Future<List<PortfolioModel>> getPortfolios() async {
    try {
      final response = await _dio.get(ApiEndpoints.mePortfolios);
      final data = response.data['data'] as List<dynamic>? ?? const [];
      return [
        for (final (index, json)
            in data.whereType<Map<String, dynamic>>().indexed)
          PortfolioModel.fromJson(json, isPrimary: index == 0),
      ];
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<void> setActive(String id, bool isActive) async {
    try {
      await _dio.patch(
        ApiEndpoints.mePortfolioStatus(id),
        data: {'isActive': isActive},
      );
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await _dio.delete(ApiEndpoints.mePortfolio(id));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }
}
