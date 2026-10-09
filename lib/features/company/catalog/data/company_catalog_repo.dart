import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../../profile_completion/data/models/catalog_model.dart';
import 'catalog_item_draft.dart';

class CompanyCatalogRepo {
  CompanyCatalogRepo({required DioClient dio}) : _dio = dio;

  final DioClient _dio;

  Future<CatalogModel> getCatalog() async {
    try {
      final response = await _dio.get(ApiEndpoints.meCatalog);
      return CatalogModel.fromJson(
          response.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<void> enableKinds({
    required bool productsEnabled,
    required bool servicesEnabled,
  }) async {
    try {
      await _dio.put(
        ApiEndpoints.meCatalog,
        data: {
          'productsEnabled': productsEnabled,
          'servicesEnabled': servicesEnabled,
        },
      );
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Map<String, dynamic> _fields({
    required String kind,
    required String name,
    required String description,
    required String price,
    required String priceLabel,
    required String actionType,
    required String actionUrl,
    required int sortOrder,
    required bool isActive,
  }) =>
      {
        'kind': kind,
        'name': name,
        'description': description,
        'price': price,
        'priceLabel': priceLabel,
        'actionType': actionType,
        'actionUrl': actionUrl,
        'sortOrder': sortOrder < 1 ? 1 : sortOrder,
        'isActive': isActive ? 1 : 0,
      };

  CatalogItemModel? _itemOrNull(Response response) {
    final data = response.data['data'];
    if (data is Map<String, dynamic> && data['id'] != null) {
      return CatalogItemModel.fromJson(data);
    }
    return null;
  }

  Future<CatalogItemModel?> create(
      CatalogItemDraft draft, int sortOrder) async {
    try {
      final image = draft.image;
      final response = await _dio.postForm(
        ApiEndpoints.meProducts,
        FormData.fromMap({
          ..._fields(
            kind: draft.kind,
            name: draft.name,
            description: draft.description,
            price: draft.price,
            priceLabel: draft.priceLabel,
            actionType: draft.actionType,
            actionUrl: draft.actionUrl,
            sortOrder: sortOrder,
            isActive: true,
          ),
          if (image != null)
            'image': await MultipartFile.fromFile(
              image.path,
              filename: image.path.split('/').last,
            ),
        }),
      );
      return _itemOrNull(response);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<CatalogItemModel?> update(
    CatalogItemModel item, {
    CatalogItemDraft? draft,
  }) async {
    try {
      final image = draft?.image;
      final response = await _dio.postForm(
        ApiEndpoints.meCatalogItem(item.kind, item.id),
        FormData.fromMap({
          '_method': 'PUT',
          ..._fields(
            kind: item.kind,
            name: draft?.name ?? item.name,
            description: draft?.description ?? item.description,
            price: draft?.price ?? item.price,
            priceLabel: draft?.priceLabel ?? item.priceLabel,
            actionType: draft?.actionType ?? item.actionType,
            actionUrl: draft?.actionUrl ?? item.actionUrl,
            sortOrder: item.sortOrder,
            isActive: item.isActive,
          ),
          if (image != null)
            'image': await MultipartFile.fromFile(
              image.path,
              filename: image.path.split('/').last,
            ),
        }),
      );
      return _itemOrNull(response);
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }

  Future<void> delete(CatalogItemModel item) async {
    try {
      await _dio.delete(ApiEndpoints.meCatalogItem(item.kind, item.id));
    } on DioException catch (e) {
      throw NetworkException.fromDioException(e);
    }
  }
}
