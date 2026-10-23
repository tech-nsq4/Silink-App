import 'package:dio/dio.dart';

import '../../../core/network/dio_client.dart';
import '../../../core/network/network_exceptions.dart';
import 'models/profile_card_model.dart';

class ProfileCardRepo {
  ProfileCardRepo({required DioClient dio, String scope = 'me'})
      : _dio = dio,
        _scope = scope;

  final DioClient _dio;
  final String _scope;

  Future<ProfileCardModel> getMyCard() async {
    try {
      final response = await _dio.get('$_scope/card');
      return ProfileCardModel.fromJson(
          response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }
}
