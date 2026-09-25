import 'package:dio/dio.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_exceptions.dart';
import 'models/profile_card_model.dart';

class ProfileCardRepo {
  ProfileCardRepo({required DioClient dio}) : _dio = dio;

  final DioClient _dio;

  Future<ProfileCardModel> getMyCard() async {
    try {
      final response = await _dio.get(ApiEndpoints.meCard);
      return ProfileCardModel.fromJson(
          response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }
}
