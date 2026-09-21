import 'package:dio/dio.dart';

import 'package:Silink/core/network/api_endpoints.dart';
import 'package:Silink/core/network/dio_client.dart';
import 'package:Silink/core/network/network_exceptions.dart';
import 'models/company.dart';

class CompanyRepo {
  CompanyRepo({required DioClient dio}) : _dio = dio;

  final DioClient _dio;

  Future<Company> createCompany(Company company) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.companies,
        data: company.toJson(),
      );
      final data = response.data?['data'];
      if (data is Map<String, dynamic>) return Company.fromJson(data);
      return confirmLocally(company);
    } on DioException catch (error) {
      if (error.type == DioExceptionType.badResponse) {
        throw NetworkException.fromDioException(error);
      }
      return confirmLocally(company);
    }
  }

  Company confirmLocally(Company company) => company.copyWith(
        slug:
            company.slug.isEmpty ? _slugFromName(company.name) : company.slug,
        createdAt: company.createdAt.isEmpty
            ? DateTime.now().toIso8601String()
            : company.createdAt,
      );

  String _slugFromName(String name) =>
      name.trim().isEmpty ? 'company' : name.trim().replaceAll(' ', '-');
}
