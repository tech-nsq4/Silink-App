import 'package:dio/dio.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_exceptions.dart';
import 'models/product.dart';
import 'store_catalog.dart';

class StoreRepo {
  StoreRepo({required DioClient dio}) : _dio = dio;

  final DioClient _dio;

  Future<List<Product>> fetchProducts() async {
    try {
      final response =
          await _dio.get<Map<String, dynamic>>(ApiEndpoints.baseUrl);
      return _parseProducts(response.data?['data']);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  List<Product> localProducts() => StoreCatalog.products();

  Product? localProductById(String id) => StoreCatalog.productById(id);

  List<Product> _parseProducts(dynamic data) {
    final raw = data is Map<String, dynamic> ? data['products'] : data;
    if (raw is! List) return const [];
    return raw
        .whereType<Map<String, dynamic>>()
        .map(Product.fromJson)
        .toList(growable: false);
  }
}
