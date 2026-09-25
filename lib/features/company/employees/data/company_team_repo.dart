import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/network_exceptions.dart';
import 'models/company_employee_model.dart';

class CompanyTeamRepo {
  CompanyTeamRepo({required DioClient dio}) : _dio = dio;

  final DioClient _dio;

  Map<String, dynamic> _data(Response response) =>
      response.data['data'] as Map<String, dynamic>;

  CompanyEmployeeModel _member(Response response) {
    final data = _data(response);
    final member = data['member'];
    return CompanyEmployeeModel.fromJson(
      member is Map<String, dynamic> ? member : data,
    );
  }

  Future<List<CompanyEmployeeModel>> getTeam() async {
    try {
      final response = await _dio.get(ApiEndpoints.meCompanyTeam);
      final members = _data(response)['members'] as List? ?? const [];
      return members
          .map((e) => CompanyEmployeeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<CompanyEmployeeModel> createMember({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String whatsapp,
    required String position,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.meCompanyTeam,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          'whatsapp': whatsapp,
          'position': position,
        },
      );
      return _member(response);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<CompanyEmployeeModel> updateMember({
    required String id,
    required String name,
    required String email,
    required String phone,
    required String whatsapp,
    required String position,
    String? password,
  }) async {
    try {
      final response = await _dio.put(
        ApiEndpoints.meCompanyTeamMember(id),
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'whatsapp': whatsapp,
          'position': position,
          if (password != null && password.isNotEmpty) 'password': password,
        },
      );
      return _member(response);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<void> deleteMember(String id) async {
    try {
      await _dio.delete(ApiEndpoints.meCompanyTeamMember(id));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }
}
