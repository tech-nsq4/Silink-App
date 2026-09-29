import 'package:dio/dio.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_exceptions.dart';
import 'models/product.dart';

class StoreRepo {
  StoreRepo({required DioClient dio}) : _dio = dio;

  final DioClient _dio;

  Future<List<Product>> getNfcProducts() async {
    try {
      final response = await _dio.get(ApiEndpoints.nfcProducts);
      final data = response.data['data'];
      return data is List
          ? data
              .whereType<Map<String, dynamic>>()
              .map(Product.fromJson)
              .toList(growable: false)
          : const [];
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }
}
