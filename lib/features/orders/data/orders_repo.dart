import 'package:dio/dio.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_exceptions.dart';
import 'models/my_order_model.dart';

class OrdersRepo {
  OrdersRepo({required DioClient dio}) : _dio = dio;

  final DioClient _dio;

  Future<List<MyOrderModel>> getOrders() async {
    try {
      final response = await _dio.get(ApiEndpoints.meOrders);
      final data = response.data['data'];
      return data is List
          ? data
              .whereType<Map<String, dynamic>>()
              .map(MyOrderModel.fromJson)
              .toList(growable: false)
          : const [];
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<MyOrderModel> cancelOrder(MyOrderModel order) async {
    try {
      final response = await _dio.post(ApiEndpoints.meOrderCancel(order.id));
      final data = response.data['data'];
      final json = data is Map<String, dynamic>
          ? (data['order'] is Map<String, dynamic>
              ? data['order'] as Map<String, dynamic>
              : data)
          : null;
      final updated = json == null || json['id'] == null
          ? null
          : MyOrderModel.fromJson(json);
      return updated?.isCancelled ?? false ? updated! : order.markCancelled();
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }
}
