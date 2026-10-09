import 'package:dio/dio.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_exceptions.dart';
import 'models/client_category_model.dart';
import 'models/client_model.dart';
import 'models/client_request.dart';

class ClientsRepo {
  ClientsRepo({required DioClient dio}) : _dio = dio;

  final DioClient _dio;
  List<ClientCategoryModel>? _categories;

  Future<List<ClientCategoryModel>> getCategories({bool force = false}) async {
    final cached = _categories;
    if (cached != null && !force) return cached;
    try {
      final response = await _dio.get(ApiEndpoints.meClientCategories);
      final data = response.data['data'] as List<dynamic>? ?? [];
      return _categories = data
          .whereType<Map<String, dynamic>>()
          .map(ClientCategoryModel.fromJson)
          .toList();
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<List<ClientModel>> getClients() async {
    try {
      final response = await _dio.get(ApiEndpoints.meClients);
      final data = response.data['data'] as List<dynamic>? ?? [];
      return data
          .whereType<Map<String, dynamic>>()
          .map(ClientModel.fromJson)
          .toList();
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<ClientModel> getClient(String id) async {
    try {
      final response = await _dio.get(ApiEndpoints.meClient(id));
      return ClientModel.fromJson(
          response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<ClientModel?> createClient(ClientRequest request) async {
    try {
      final response =
          await _dio.post(ApiEndpoints.meClients, data: request.toJson());
      return _clientOrNull(response);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<ClientModel> updateClient(String id, ClientRequest request) async {
    try {
      final response =
          await _dio.put(ApiEndpoints.meClient(id), data: request.toJson());
      return _clientOrNull(response) ?? await getClient(id);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<void> deleteClient(String id) async {
    try {
      await _dio.delete(ApiEndpoints.meClient(id));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  ClientModel? _clientOrNull(Response response) {
    final data = response.data['data'];
    if (data is Map<String, dynamic> && data['id'] != null) {
      return ClientModel.fromJson(data);
    }
    return null;
  }
}
