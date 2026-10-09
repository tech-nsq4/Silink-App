import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_exceptions.dart';
import '../../../core/storage/local_storage.dart';
import '../../auth/data/models/user_model.dart';

class AccountRepo {
  AccountRepo({required DioClient dio, required LocalStorage storage})
      : _dio = dio,
        _storage = storage;

  final DioClient _dio;
  final LocalStorage _storage;

  Future<UserModel> updateProfile({
    required String name,
    required String phone,
    String? email,
    File? image,
  }) async {
    try {
      final form = FormData.fromMap({
        'name': name,
        'phone': phone,
        if (email != null && email.isNotEmpty) 'email': email,
        if (image != null)
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
      });
      final response = await _dio.postForm(ApiEndpoints.profile, form);
      final user = _userFrom(response) ?? await _fetchProfile();
      await _storage.setUser(user.toJson());
      return user;
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      await _dio.post(
        ApiEndpoints.mePassword,
        data: {
          'currentPassword': currentPassword,
          'password': password,
          'passwordConfirmation': passwordConfirmation,
        },
      );
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<void> updateFcmToken(String token) async {
    try {
      await _dio.post(ApiEndpoints.meFcmToken, data: {'fcmToken': token});
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<UserModel> _fetchProfile() async {
    final response = await _dio.get(ApiEndpoints.profile);
    return _userFrom(response)!;
  }

  UserModel? _userFrom(Response response) {
    final data = response.data['data'];
    if (data is! Map<String, dynamic>) return null;
    final user = data['user'];
    if (user is Map<String, dynamic>) return UserModel.fromJson(user);
    if (data['id'] != null) return UserModel.fromJson(data);
    return null;
  }
}
