import 'package:dio/dio.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_exceptions.dart';
import 'models/subscription_plan.dart';

class SubscriptionRepo {
  SubscriptionRepo({required DioClient dio}) : _dio = dio;

  final DioClient _dio;

  Future<List<SubscriptionPlan>> getSubscriptions() async {
    try {
      final response = await _dio.get(ApiEndpoints.subscriptions);
      final data = response.data['data'];
      return data is List
          ? data
              .whereType<Map<String, dynamic>>()
              .map(SubscriptionPlan.fromJson)
              .toList(growable: false)
          : const [];
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }
}
