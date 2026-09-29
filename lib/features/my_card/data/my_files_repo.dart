import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_exceptions.dart';
import 'models/file_category_model.dart';
import 'models/my_file_model.dart';

class MyFilesRepo {
  MyFilesRepo({required DioClient dio}) : _dio = dio;

  final DioClient _dio;

  dynamic _data(Response response) => response.data['data'];

  List<Map<String, dynamic>> _list(Response response, String nestedKey) {
    final data = _data(response);
    final list = data is Map<String, dynamic> ? data[nestedKey] : data;
    return list is List
        ? list.whereType<Map<String, dynamic>>().toList()
        : const [];
  }

  Future<List<FileCategoryModel>> getCategories() async {
    try {
      final response = await _dio.get(ApiEndpoints.meFileCategories);
      return _list(response, 'categories')
          .map(FileCategoryModel.fromJson)
          .toList();
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<List<MyFileModel>> getFiles() async {
    try {
      final response = await _dio.get(ApiEndpoints.meFiles);
      return _list(response, 'files').map(MyFileModel.fromJson).toList();
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<MyFileModel> getFile(String id) async {
    try {
      final response = await _dio.get(ApiEndpoints.meFile(id));
      final data = _data(response) as Map<String, dynamic>;
      final file = data['file'];
      return MyFileModel.fromJson(
        file is Map<String, dynamic> ? file : data,
      );
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<FormData> _fileForm({
    required String name,
    required String note,
    required List<String> categoryIds,
    File? file,
    String? methodOverride,
  }) async {
    final form = FormData()
      ..fields.addAll([
        if (methodOverride != null) MapEntry('_method', methodOverride),
        MapEntry('name', name),
        MapEntry('note', note),
        for (final id in categoryIds) MapEntry('categoryIds[]', id),
      ]);
    if (file != null) {
      form.files.add(MapEntry(
        'file',
        await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      ));
    }
    return form;
  }

  Future<void> createFile({
    required String name,
    required String note,
    required List<String> categoryIds,
    required File file,
  }) async {
    try {
      final form = await _fileForm(
        name: name,
        note: note,
        categoryIds: categoryIds,
        file: file,
      );
      await _dio.postForm(ApiEndpoints.meFiles, form);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<void> updateFile({
    required String id,
    required String name,
    required String note,
    required List<String> categoryIds,
    File? file,
  }) async {
    try {
      final form = await _fileForm(
        name: name,
        note: note,
        categoryIds: categoryIds,
        file: file,
        methodOverride: 'PUT',
      );
      await _dio.postForm(ApiEndpoints.meFile(id), form);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<void> deleteFile(String id) async {
    try {
      await _dio.delete(ApiEndpoints.meFile(id));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }
}
