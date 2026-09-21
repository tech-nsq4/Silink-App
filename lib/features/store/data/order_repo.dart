import 'dart:math';

import 'package:dio/dio.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_exceptions.dart';
import 'models/store_order.dart';

class OrderRepo {
  OrderRepo({required DioClient dio}) : _dio = dio;

  final DioClient _dio;

  Future<StoreOrder> placeOrder(StoreOrder order) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.baseUrl,
        data: order.toJson(),
      );
      final data = response.data?['data'];
      if (data is Map<String, dynamic>) return StoreOrder.fromJson(data);
      return confirmLocally(order);
    } on DioException catch (error) {
      if (error.type == DioExceptionType.badResponse) {
        throw NetworkException.fromDioException(error);
      }
      return confirmLocally(order);
    }
  }

  StoreOrder confirmLocally(StoreOrder order) => order.copyWith(
        number: order.number.isEmpty ? generateOrderNumber() : order.number,
        createdAt:
            order.createdAt.isEmpty ? DateTime.now().toIso8601String() : null,
      );

  String generateOrderNumber() {
    final random = Random();
    final groups = List.generate(4, (_) => 1000 + random.nextInt(9000));
    return groups.join('-');
  }
}
