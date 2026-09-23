import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/network_exceptions.dart';
import 'models/company_details_model.dart';
import 'models/company_option_model.dart';
import 'models/company_profile_model.dart';

class CompanyProfileCompletionRepo {
  CompanyProfileCompletionRepo({required DioClient dio}) : _dio = dio;

  final DioClient _dio;

  Map<String, dynamic> _data(Response response) =>
      response.data['data'] as Map<String, dynamic>;

  Future<CompanyProfileModel> getCompanyProfile() async {
    try {
      final response = await _dio.get(ApiEndpoints.meCompany);
      return CompanyProfileModel.fromJson(_data(response));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<CompanyProfileModel> saveCompanyProfile({
    required String companyName,
    required String about,
    required String website,
    File? logo,
  }) async {
    try {
      final form = FormData.fromMap({
        '_method': 'PUT',
        'companyName': companyName,
        'about': about,
        'website': website,
        if (logo != null)
          'logo': await MultipartFile.fromFile(
            logo.path,
            filename: logo.path.split('/').last,
          ),
      });
      final response = await _dio.postForm(ApiEndpoints.meCompany, form);
      return CompanyProfileModel.fromJson(_data(response));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<CompanyIndustryModel> getIndustries() async {
    try {
      final response = await _dio.get(ApiEndpoints.meCompanyIndustry);
      return CompanyIndustryModel.fromJson(_data(response));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<CompanyIndustryModel> saveIndustry(String industryId) async {
    try {
      final response = await _dio.put(
        ApiEndpoints.meCompanyIndustry,
        data: {'industryId': industryId},
      );
      return CompanyIndustryModel.fromJson(_data(response));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<CompanySubIndustryModel> getSubIndustries() async {
    try {
      final response = await _dio.get(ApiEndpoints.meCompanySubIndustry);
      return CompanySubIndustryModel.fromJson(_data(response));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<CompanySubIndustryModel> saveSubIndustry(String subIndustryId) async {
    try {
      final response = await _dio.put(
        ApiEndpoints.meCompanySubIndustry,
        data: {'subIndustryId': subIndustryId},
      );
      return CompanySubIndustryModel.fromJson(_data(response));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<CompanyDetailsModel> getDetails() async {
    try {
      final response = await _dio.get(ApiEndpoints.meCompanyDetails);
      return CompanyDetailsModel.fromJson(_data(response));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<CompanyDetailsModel> saveDetails({
    required String companySize,
    required String cityId,
    required String contactPhone,
    required String companyEmail,
  }) async {
    try {
      final response = await _dio.put(
        ApiEndpoints.meCompanyDetails,
        data: {
          'companySize': companySize,
          'cityId': cityId,
          'contactPhone': contactPhone,
          'companyEmail': companyEmail,
        },
      );
      return CompanyDetailsModel.fromJson(_data(response));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }
}
