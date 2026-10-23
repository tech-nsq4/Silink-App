import 'package:dio/dio.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_exceptions.dart';
import '../../../core/storage/local_storage.dart';
import '../../auth/data/models/user_model.dart';
import 'models/invitation_details_model.dart';

class EmployeeInvitationRepo {
  EmployeeInvitationRepo({
    required DioClient dio,
    required LocalStorage storage,
  })  : _dio = dio,
        _storage = storage;

  final DioClient _dio;
  final LocalStorage _storage;

  Future<InvitationDetailsModel> getInvitation(String inviteToken) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.employeeInvitation,
        options: DioClient.bearerOptions(inviteToken),
      );
      return InvitationDetailsModel.fromJson(
        response.data['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<UserModel> acceptInvitation({
    required String inviteToken,
    required String name,
    required String email,
    required String phone,
    required String position,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.employeeInvitationAccept,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'position': position,
          'password': password,
        },
        options: DioClient.bearerOptions(inviteToken),
      );
      final data = response.data['data'] as Map<String, dynamic>;
      final user = UserModel.fromJson(data['user'] as Map<String, dynamic>);
      await _storage.setToken(data['token'] as String);
      await _storage.setUser(user.toJson());
      return user;
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }
}
