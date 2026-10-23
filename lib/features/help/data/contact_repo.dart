import 'package:dio/dio.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_exceptions.dart';
import 'models/contact_message.dart';

class ContactRepo {
  ContactRepo({required DioClient dio}) : _dio = dio;

  final DioClient _dio;

  Future<void> send(ContactMessage message) async {
    try {
      await _dio.post(ApiEndpoints.contactMessages, data: message.toJson());
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }
}
