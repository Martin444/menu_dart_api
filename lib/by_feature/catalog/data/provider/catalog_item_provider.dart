import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:menu_dart_api/by_feature/catalog/data/repository/catalog_item_repository.dart';
import 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';
import 'package:menu_dart_api/by_feature/catalog/models/create_catalog_item_params.dart';
import 'package:menu_dart_api/by_feature/catalog/models/update_catalog_item_params.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';
import 'package:menu_dart_api/core/helpers/multipart_helper.dart';

/// Provider que implementa las operaciones de items de catálogos
class CatalogItemProvider extends CatalogItemRepository {
  final dio.Dio _dio = dio.Dio();

  @override
  Future<CatalogItemModel> createItem(CreateCatalogItemParams params) async {
    try {
      final Uri url = Uri.parse(
        '${API.defaulBaseUrl}/catalogs/${params.catalogId}/items',
      );

      // Construir FormData
      final formDataMap = <String, dynamic>{};

      // Agregar campos requeridos
      formDataMap['name'] = params.name;
      formDataMap['price'] = params.price.toString();

      // Agregar campos opcionales
      if (params.description != null) formDataMap['description'] = params.description;
      if (params.discountPrice != null) {
        formDataMap['discountPrice'] = params.discountPrice.toString();
      }
      if (params.quantity != null) formDataMap['quantity'] = params.quantity.toString();
      if (params.sku != null) formDataMap['sku'] = params.sku;
      if (params.isAvailable != null) {
        formDataMap['isAvailable'] = MultipartHelper.encodeBool(params.isAvailable!);
      }
      if (params.isFeatured != null) {
        formDataMap['isFeatured'] = MultipartHelper.encodeBool(params.isFeatured!);
      }
      if (params.category != null) formDataMap['category'] = params.category;
      if (params.displayOrder != null) {
        formDataMap['displayOrder'] = params.displayOrder.toString();
      }

      // Agregar JSON fields
      if (params.attributes != null) {
        formDataMap['attributes'] = MultipartHelper.encodeJson(params.attributes);
      }

      // Agregar tags
      if (params.tags != null && params.tags!.isNotEmpty) {
        formDataMap['tags'] = params.tags;
      }

      // Agregar imagen si existe
      if (params.photo != null) {
        formDataMap['photo'] = dio.MultipartFile.fromBytes(
          params.photo!,
          filename: MultipartHelper.generateFilename(
            prefix: 'catalog-item',
            extension: 'jpg',
          ),
        );
      }

      final formData = dio.FormData.fromMap(formDataMap);

      final response = await _dio.post(
        url.toString(),
        data: formData,
        options: dio.Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer ${API.loginAccessToken}',
          },
        ),
      );

      if (response.statusCode != 201) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      var responseData = response.data is String ? jsonDecode(response.data) : response.data;

      if (responseData is Map && responseData.containsKey('data')) {
        responseData = responseData['data'];
      }

      return CatalogItemModel.fromJson(responseData as Map<String, dynamic>);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al crear item',
        );
      }
      rethrow;
    }
  }

  @override
  Future<CatalogItemModel> getItemById({
    required String catalogId,
    required String itemId,
  }) async {
    try {
      final Uri url = Uri.parse(
        '${API.defaulBaseUrl}/catalogs/$catalogId/items/$itemId',
      );

      final response = await _dio.get(
        url.toString(),
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${API.loginAccessToken}',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      var responseData = response.data is String ? jsonDecode(response.data) : response.data;

      if (responseData is Map && responseData.containsKey('data')) {
        responseData = responseData['data'];
      }

      return CatalogItemModel.fromJson(responseData as Map<String, dynamic>);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al obtener item',
        );
      }
      rethrow;
    }
  }

  @override
  Future<CatalogItemModel> updateItem(UpdateCatalogItemParams params) async {
    try {
      final Uri url = Uri.parse(
        '${API.defaulBaseUrl}/catalogs/${params.catalogId}/items/${params.itemId}',
      );

      // Construir FormData
      final formDataMap = <String, dynamic>{};

      // Agregar solo los campos que no son null
      if (params.name != null) formDataMap['name'] = params.name;
      if (params.description != null) formDataMap['description'] = params.description;
      if (params.photoURL != null) formDataMap['photoURL'] = params.photoURL;
      if (params.price != null) formDataMap['price'] = params.price.toString();
      if (params.discountPrice != null) {
        formDataMap['discountPrice'] = params.discountPrice.toString();
      }
      if (params.quantity != null) formDataMap['quantity'] = params.quantity.toString();
      if (params.sku != null) formDataMap['sku'] = params.sku;
      if (params.status != null) formDataMap['status'] = params.status;
      if (params.isAvailable != null) {
        formDataMap['isAvailable'] = MultipartHelper.encodeBool(params.isAvailable!);
      }
      if (params.isFeatured != null) {
        formDataMap['isFeatured'] = MultipartHelper.encodeBool(params.isFeatured!);
      }
      if (params.category != null) formDataMap['category'] = params.category;
      if (params.displayOrder != null) {
        formDataMap['displayOrder'] = params.displayOrder.toString();
      }

      // Agregar JSON fields
      if (params.attributes != null) {
        formDataMap['attributes'] = MultipartHelper.encodeJson(params.attributes);
      }

      // Agregar additional images
      if (params.additionalImages != null && params.additionalImages!.isNotEmpty) {
        formDataMap['additionalImages'] = params.additionalImages;
      }

      // Agregar tags
      if (params.tags != null && params.tags!.isNotEmpty) {
        formDataMap['tags'] = params.tags;
      }

      // Agregar nueva imagen si existe
      if (params.photo != null) {
        formDataMap['photo'] = dio.MultipartFile.fromBytes(
          params.photo!,
          filename: MultipartHelper.generateFilename(
            prefix: 'catalog-item-updated',
            extension: 'jpg',
          ),
        );
      }

      final formData = dio.FormData.fromMap(formDataMap);

      final response = await _dio.put(
        url.toString(),
        data: formData,
        options: dio.Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer ${API.loginAccessToken}',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      var responseData = response.data is String ? jsonDecode(response.data) : response.data;

      if (responseData is Map && responseData.containsKey('data')) {
        responseData = responseData['data'];
      }

      return CatalogItemModel.fromJson(responseData as Map<String, dynamic>);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al actualizar item',
        );
      }
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> deleteItem({
    required String catalogId,
    required String itemId,
  }) async {
    try {
      final Uri url = Uri.parse(
        '${API.defaulBaseUrl}/catalogs/$catalogId/items/$itemId',
      );

      final response = await _dio.delete(
        url.toString(),
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${API.loginAccessToken}',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      var responseData = response.data is String ? jsonDecode(response.data) : response.data;

      if (responseData is Map && responseData.containsKey('data')) {
        responseData = responseData['data'];
      }

      return responseData as Map<String, dynamic>;
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al eliminar item',
        );
      }
      rethrow;
    }
  }
}
