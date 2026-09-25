import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_exceptions.dart';
import '../../../core/storage/local_storage.dart';
import 'models/registration_ticket.dart';
import 'models/user_model.dart';

class AuthRepo {
  AuthRepo({required DioClient dio, required LocalStorage storage})
      : _dio = dio,
        _storage = storage;

  final DioClient _dio;
  final LocalStorage _storage;

  Future<UserModel> login({
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.login,
        data: {
          'phone': phone,
          'password': password,
        },
      );
      final responseData = response.data['data'] as Map<String, dynamic>;
      final user = UserModel.fromJson(responseData['user'] as Map<String, dynamic>);
      final token = responseData['token'] as String?;
      if (token != null) {
        await _storage.setToken(token);
        await _storage.setUser(user.toJson());
      }
      return user;
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<RegistrationTicket> registerCompany({
    required String fullName,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.register,
        data: {
          'usageIntent': 'company',
          'fullName': fullName,
          'phone': phone,
          'email': email,
          'password': password,
        },
      );
      return RegistrationTicket.fromJson(
          response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<RegistrationTicket> registerPersonal({
    required String usageIntent,
    required String profileType,
    required String fullName,
    required String jobTitle,
    String? company,
    String? bio,
    String? address,
    double? lat,
    double? lng,
    required String phone,
    String? email,
    String? password,
    File? photo,
  }) async {
    try {
      final form = FormData.fromMap({
        'usageIntent': usageIntent,
        'profileType': profileType,
        'fullName': fullName,
        'jobTitle': jobTitle,
        if (company != null && company.trim().isNotEmpty) 'company': company,
        if (bio != null && bio.trim().isNotEmpty) 'bio': bio,
        if (address != null && address.trim().isNotEmpty) 'address': address,
        if (lat != null) 'lat': lat,
        if (lng != null) 'lng': lng,
        'phone': phone,
        if (email != null && email.trim().isNotEmpty) 'email': email,
        if (password != null && password.trim().isNotEmpty)
          'password': password,
        if (photo != null)
          'photo': await MultipartFile.fromFile(
            photo.path,
            filename: photo.path.split('/').last,
          ),
      });
      final response = await _dio.postForm(ApiEndpoints.register, form);
      return RegistrationTicket.fromJson(
          response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<UserModel> verifyOtp({
    required String registrationId,
    required String code,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.verifyOtp,
        data: {
          'registrationId': registrationId,
          'code': code,
        },
      );
      final responseData = response.data['data'] as Map<String, dynamic>;
      final user =
          UserModel.fromJson(responseData['user'] as Map<String, dynamic>);
      final token = responseData['token'] as String?;
      if (token != null) {
        await _storage.setToken(token);
        await _storage.setUser(user.toJson());
      }
      return user;
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<UserModel> getProfile() async {
    try {
      final response = await _dio.get(ApiEndpoints.profile);
      final data = response.data['data'] as Map<String, dynamic>;
      return UserModel.fromJson(data['user'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<void> logout() async {
    await _storage.clearAll();
  }
}
