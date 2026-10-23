import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/network_exceptions.dart';
import 'models/company_employee_model.dart';
import 'models/employee_invitation_model.dart';

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
    required String phone,
    required String position,
    String department = '',
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.meCompanyTeam,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'position': position,
          if (department.isNotEmpty) 'department': department,
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

  Future<void> updateMemberStatus(String id, {required bool active}) async {
    try {
      await _dio.patch(
        ApiEndpoints.meCompanyTeamMemberStatus(id),
        data: {'status': active ? 'active' : 'disabled'},
      );
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<EmployeeInvitationModel> resendInvitation(String id) async {
    try {
      final response =
          await _dio.post(ApiEndpoints.meCompanyTeamMemberInvitation(id));
      final data = _data(response);
      final member = data['member'];
      final invitation = data['invitation'] ??
          (member is Map<String, dynamic> ? member['invitation'] : null);
      return EmployeeInvitationModel.fromJson(
        invitation as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }
}
