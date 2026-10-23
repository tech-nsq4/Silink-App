import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_exceptions.dart';
import 'models/appearance_model.dart';
import 'models/arrangement_section_model.dart';
import 'models/catalog_model.dart';
import 'models/channel_model.dart';
import 'models/link_model.dart';
import 'models/template_model.dart';

class ProfileCompletionRepo {
  ProfileCompletionRepo({required DioClient dio, String scope = 'me'})
      : _dio = dio,
        _scope = scope;

  final DioClient _dio;
  final String _scope;

  String _path(String step) => '$_scope/$step';

  Map<String, dynamic> _data(Response response) =>
      response.data['data'] as Map<String, dynamic>;

  Future<List<ChannelModel>> getChannels() async {
    try {
      final response = await _dio.get(_path('channels'));
      final channels = _data(response)['channels'] as List<dynamic>? ?? [];
      return channels
          .map((e) => ChannelModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<List<ChannelModel>> saveChannels(List<ChannelModel> channels) async {
    try {
      final response = await _dio.put(
        _path('channels'),
        data: {'channels': channels.map((c) => c.toJson()).toList()},
      );
      final result = _data(response)['channels'] as List<dynamic>? ?? [];
      return result
          .map((e) => ChannelModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<List<LinkModel>> getLinks() async {
    try {
      final response = await _dio.get(_path('links'));
      final links = _data(response)['links'] as List<dynamic>? ?? [];
      return links
          .map((e) => LinkModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<List<LinkModel>> saveLinks(List<LinkModel> links) async {
    try {
      final response = await _dio.put(
        _path('links'),
        data: {'links': links.map((l) => l.toJson()).toList()},
      );
      final result = _data(response)['links'] as List<dynamic>? ?? [];
      return result
          .map((e) => LinkModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<CatalogModel> getCatalog() async {
    try {
      final response = await _dio.get(_path('catalog'));
      return CatalogModel.fromJson(_data(response));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<CatalogModel> saveCatalogSettings({
    required bool productsEnabled,
    required bool servicesEnabled,
  }) async {
    try {
      final response = await _dio.put(
        _path('catalog'),
        data: {
          'productsEnabled': productsEnabled,
          'servicesEnabled': servicesEnabled,
        },
      );
      return CatalogModel.fromJson(_data(response));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  FormData _catalogItemForm({
    required String kind,
    required String name,
    required String description,
    required String priceLabel,
    required String price,
    required String actionType,
    required String actionUrl,
    File? image,
    String? methodOverride,
  }) =>
      FormData.fromMap({
        if (methodOverride != null) '_method': methodOverride,
        'kind': kind,
        'name': name,
        'description': description,
        'priceLabel': priceLabel,
        'price': price,
        'actionType': actionType,
        'actionUrl': actionUrl,
        if (image != null)
          'image': MultipartFile.fromFileSync(
            image.path,
            filename: image.path.split('/').last,
          ),
      });

  Future<CatalogModel> addCatalogItem({
    required String kind,
    required String name,
    required String description,
    required String priceLabel,
    required String price,
    required String actionType,
    required String actionUrl,
    File? image,
  }) async {
    try {
      final form = _catalogItemForm(
        kind: kind,
        name: name,
        description: description,
        priceLabel: priceLabel,
        price: price,
        actionType: actionType,
        actionUrl: actionUrl,
        image: image,
      );
      final response = await _dio.postForm(ApiEndpoints.meCatalogItems, form);
      return CatalogModel.fromJson(_data(response));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<CatalogItemModel> updateCatalogItem({
    required String id,
    required String kind,
    required String name,
    required String description,
    required String priceLabel,
    required String price,
    required String actionType,
    required String actionUrl,
    File? image,
  }) async {
    try {
      final form = _catalogItemForm(
        kind: kind,
        name: name,
        description: description,
        priceLabel: priceLabel,
        price: price,
        actionType: actionType,
        actionUrl: actionUrl,
        image: image,
        methodOverride: 'PUT',
      );
      final response =
          await _dio.postForm(ApiEndpoints.meCatalogItem(kind, id), form);
      return CatalogItemModel.fromJson(_data(response));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<void> deleteCatalogItem({required String id, required String kind}) async {
    try {
      await _dio.delete(ApiEndpoints.meCatalogItem(kind, id));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<List<ArrangementSectionModel>> getArrangement() async {
    try {
      final response = await _dio.get(_path('arrangement'));
      final sections = _data(response)['sections'] as List<dynamic>? ?? [];
      return sections
          .map((e) =>
              ArrangementSectionModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<List<ArrangementSectionModel>> saveArrangement(
    List<ArrangementSectionModel> sections,
  ) async {
    try {
      final response = await _dio.put(
        _path('arrangement'),
        data: {
          'sections': [
            for (final entry in sections.indexed)
              if (!entry.$2.locked)
                {
                  'type': entry.$2.type,
                  'visible': entry.$2.visible,
                  'sortOrder': entry.$1,
                },
          ],
        },
      );
      final result = _data(response)['sections'] as List<dynamic>? ?? [];
      return result
          .map((e) =>
              ArrangementSectionModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<TemplateSettings> getTemplates() async {
    try {
      final response = await _dio.get(_path('template'));
      return TemplateSettings.fromJson(_data(response));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<TemplateSettings> saveTemplate(String templateId) async {
    try {
      final response = await _dio.put(
        _path('template'),
        data: {'templateId': templateId},
      );
      return TemplateSettings.fromJson(_data(response));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<AppearanceModel> getAppearance() async {
    try {
      final response = await _dio.get(_path('appearance'));
      return AppearanceModel.fromJson(_data(response));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<AppearanceModel> saveAppearance(AppearanceModel appearance) async {
    try {
      final response = await _dio.put(
        _path('appearance'),
        data: appearance.toJson(),
      );
      return AppearanceModel.fromJson(_data(response));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }
}
