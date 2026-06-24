import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:menu_dart_api/by_feature/catalog/data/repository/catalog_repository.dart';
import 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';
import 'package:menu_dart_api/by_feature/catalog/models/create_catalog_params.dart';
import 'package:menu_dart_api/by_feature/catalog/models/update_catalog_params.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';
import 'package:menu_dart_api/core/helpers/multipart_helper.dart';

/// Provider que implementa las operaciones de catálogos
class CatalogProvider extends CatalogRepository {
  final dio.Dio _dio = dio.Dio();

  @override
  Future<CatalogModel> createCatalog(CreateCatalogParams params) async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}/catalogs');

      // Construir FormData
      final formDataMap = <String, dynamic>{};

      // Agregar campos de texto
      formDataMap['catalogType'] = params.catalogType;
      if (params.name != null) formDataMap['name'] = params.name;
      if (params.description != null) {
        formDataMap['description'] = params.description;
      }
      if (params.isPublic != null) {
        formDataMap['isPublic'] = MultipartHelper.encodeBool(params.isPublic!);
      }

      // Agregar JSON fields
      if (params.metadata != null) {
        formDataMap['metadata'] = MultipartHelper.encodeJson(params.metadata);
      }
      if (params.settings != null) {
        formDataMap['settings'] = MultipartHelper.encodeJson(params.settings);
      }

      // Agregar tags
      if (params.tags != null && params.tags!.isNotEmpty) {
        formDataMap['tags'] = MultipartHelper.encodeTags(params.tags);
      }

      // Agregar imagen si existe
      if (params.coverImage != null) {
        formDataMap['coverImage'] = dio.MultipartFile.fromBytes(
          params.coverImage!,
          filename: MultipartHelper.generateFilename(
            prefix: 'catalog-cover',
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

      var responseData =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (responseData is Map && responseData.containsKey('data')) {
        responseData = responseData['data'];
      }

      return CatalogModel.fromJson(responseData as Map<String, dynamic>);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ??
              e.message ??
              'Error al crear catálogo',
        );
      }
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getMyCatalogs({String? type}) async {
    try {
      final Uri url = type != null
          ? Uri.parse('${API.defaulBaseUrl}/catalogs/my-catalogs?type=$type')
          : Uri.parse('${API.defaulBaseUrl}/catalogs/my-catalogs');

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

      var responseData =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (responseData is Map && responseData.containsKey('data')) {
        responseData = responseData['data'];
      }

      if (responseData is! Map<String, dynamic>) {
        throw ApiException(500, 'Respuesta inválida del servidor');
      }

      final linked = (responseData['linked'] as List<dynamic>?)
              ?.map(
                  (item) => CatalogModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [];
      final unlinked = (responseData['unlinked'] as List<dynamic>?)
              ?.map(
                  (item) => CatalogModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [];

      return {'linked': linked, 'unlinked': unlinked};
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ??
              e.message ??
              'Error al obtener catálogos',
        );
      }
      rethrow;
    }
  }

  @override
  Future<CatalogModel> getCatalogById(String catalogId) async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}/catalogs/$catalogId');

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

      var responseData =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (responseData is Map && responseData.containsKey('data')) {
        responseData = responseData['data'];
      }

      return CatalogModel.fromJson(responseData as Map<String, dynamic>);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ??
              e.message ??
              'Error al obtener catálogo',
        );
      }
      rethrow;
    }
  }

  @override
  Future<CatalogModel> updateCatalog(UpdateCatalogParams params) async {
    try {
      final Uri url =
          Uri.parse('${API.defaulBaseUrl}/catalogs/${params.catalogId}');

      // Construir FormData
      final formDataMap = <String, dynamic>{};

      // Agregar solo los campos que no son null
      if (params.name != null) formDataMap['name'] = params.name;
      if (params.description != null) {
        formDataMap['description'] = params.description;
      }
      if (params.status != null) formDataMap['status'] = params.status;
      if (params.slug != null) formDataMap['slug'] = params.slug;
      if (params.isPublic != null) {
        formDataMap['isPublic'] = MultipartHelper.encodeBool(params.isPublic!);
      }

      // Agregar JSON fields
      if (params.metadata != null) {
        formDataMap['metadata'] = MultipartHelper.encodeJson(params.metadata);
      }
      if (params.settings != null) {
        formDataMap['settings'] = MultipartHelper.encodeJson(params.settings);
      }

      // Agregar tags
      if (params.tags != null && params.tags!.isNotEmpty) {
        formDataMap['tags'] = MultipartHelper.encodeTags(params.tags);
      }

      // Agregar nueva imagen si existe
      if (params.coverImage != null) {
        formDataMap['coverImage'] = dio.MultipartFile.fromBytes(
          params.coverImage!,
          filename: MultipartHelper.generateFilename(
            prefix: 'catalog-cover-updated',
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

      var responseData =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (responseData is Map && responseData.containsKey('data')) {
        responseData = responseData['data'];
      }

      return CatalogModel.fromJson(responseData as Map<String, dynamic>);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ??
              e.message ??
              'Error al actualizar catálogo',
        );
      }
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> deleteCatalog(String catalogId) async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}/catalogs/$catalogId');

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

      var responseData =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (responseData is Map && responseData.containsKey('data')) {
        responseData = responseData['data'];
      }

      return responseData as Map<String, dynamic>;
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ??
              e.message ??
              'Error al eliminar catálogo',
        );
      }
      rethrow;
    }
  }

  @override
  Future<CatalogModel> archiveCatalog(String catalogId) async {
    try {
      final Uri url =
          Uri.parse('${API.defaulBaseUrl}/catalogs/$catalogId/archive');

      final response = await _dio.put(
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

      var responseData =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (responseData is Map && responseData.containsKey('data')) {
        responseData = responseData['data'];
      }

      return CatalogModel.fromJson(responseData as Map<String, dynamic>);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ??
              e.message ??
              'Error al archivar catálogo',
        );
      }
      rethrow;
    }
  }

  @override
  Future<CatalogModel> assignCatalogToCommerce(String catalogId) async {
    try {
      final Uri url = Uri.parse(
        '${API.defaulBaseUrl}/catalogs/$catalogId/assign-to-commerce',
      );

      final response = await _dio.post(
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

      var responseData =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (responseData is Map && responseData.containsKey('data')) {
        responseData = responseData['data'];
      }

      return CatalogModel.fromJson(responseData as Map<String, dynamic>);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ??
              e.message ??
              'Error al vincular catálogo al comercio',
        );
      }
      rethrow;
    }
  }

  @override
  Future<CatalogModel> getPublicCatalogBySlug(String slug) async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}/catalogs/public/$slug');

      final response = await _dio.get(
        url.toString(),
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      var responseData =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (responseData is Map && responseData.containsKey('data')) {
        responseData = responseData['data'];
      }

      return CatalogModel.fromJson(responseData as Map<String, dynamic>);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ??
              e.message ??
              'Error al obtener catálogo público',
        );
      }
      rethrow;
    }
  }

  @override
  Future<List<CatalogModel>> searchPublicCatalogs({
    String? query,
    String? type,
    List<String>? tags,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (query != null) queryParams['query'] = query;
      if (type != null) queryParams['type'] = type;
      if (tags != null && tags.isNotEmpty) queryParams['tags'] = tags.join(',');

      final uri = Uri.parse('${API.defaulBaseUrl}/catalogs/public/search')
          .replace(
              queryParameters: queryParams.isNotEmpty ? queryParams : null);

      final response = await _dio.get(
        uri.toString(),
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      var responseData =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (responseData is Map && responseData.containsKey('data')) {
        responseData = responseData['data'];
      }

      if (responseData is! List) {
        throw ApiException(500, 'Respuesta inválida del servidor');
      }

      return responseData
          .map((item) => CatalogModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ??
              e.message ??
              'Error al buscar catálogos públicos',
        );
      }
      rethrow;
    }
  }

  @override
  Future<CatalogModel> getPublicCatalogById(String catalogId) async {
    try {
      final Uri url =
          Uri.parse('${API.defaulBaseUrl}/catalogs/public/id/$catalogId');

      final response = await _dio.get(
        url.toString(),
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      var responseData =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (responseData is Map && responseData.containsKey('data')) {
        responseData = responseData['data'];
      }

      return CatalogModel.fromJson(responseData as Map<String, dynamic>);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ??
              e.message ??
              'Error al obtener catálogo público por ID',
        );
      }
      rethrow;
    }
  }

  @override
  Future<List<CatalogModel>> getPublicCatalogsByOwnerId(String ownerId) async {
    try {
      final Uri url =
          Uri.parse('${API.defaulBaseUrl}/catalogs/public/owner/$ownerId');

      final response = await _dio.get(
        url.toString(),
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      var responseData =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (responseData is Map && responseData.containsKey('data')) {
        responseData = responseData['data'];
      }

      if (responseData is! List) {
        throw ApiException(500, 'Respuesta inválida del servidor');
      }

      return responseData
          .map((item) => CatalogModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ??
              e.message ??
              'Error al obtener catálogos públicos por ownerId',
        );
      }
      rethrow;
    }
  }

  @override
  Future<List<CatalogModel>> getPublicCatalogsByCommerce(
      String identifier) async {
    try {
      final Uri url = Uri.parse(
          '${API.defaulBaseUrl}/catalogs/public/commerce/$identifier');

      final response = await _dio.get(
        url.toString(),
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      var responseData =
          response.data is String ? jsonDecode(response.data) : response.data;

      if (responseData is Map && responseData.containsKey('data')) {
        responseData = responseData['data'];
      }

      if (responseData is! List) {
        throw ApiException(500, 'Respuesta inválida del servidor');
      }

      return responseData
          .map((item) => CatalogModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ??
              e.message ??
              'Error al obtener catálogos por comercio',
        );
      }
      rethrow;
    }
  }
}
