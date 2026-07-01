import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:menu_dart_api/by_feature/catalog/data/repository/catalog_repository.dart';
import 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';
import 'package:menu_dart_api/by_feature/catalog/models/create_catalog_params.dart';
import 'package:menu_dart_api/by_feature/catalog/models/pagination_model.dart';
import 'package:menu_dart_api/by_feature/catalog/models/update_catalog_params.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';
import 'package:menu_dart_api/core/helpers/multipart_helper.dart';

/// Provider que implementa las operaciones de catálogos
class CatalogProvider extends CatalogRepository {
  final dio.Dio _dio = dio.Dio();

  /// Extrae el body del response (unwrap `data` key si existe) y también
  /// devuelve el map completo para leer `pagination` del顶层.
  Map<String, dynamic> _unwrapResponse(dynamic rawData) {
    if (rawData is String) {
      rawData = jsonDecode(rawData);
    }
    if (rawData is Map<String, dynamic>) {
      return rawData;
    }
    throw ApiException(500, 'Respuesta inválida del servidor');
  }

  /// Extrae solo el contenido de `data` del response envuelto.
  dynamic _extractData(dynamic rawData) {
    final map = _unwrapResponse(rawData);
    if (map.containsKey('data')) {
      return map['data'];
    }
    return map;
  }

  @override
  Future<CatalogModel> createCatalog(CreateCatalogParams params) async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}/catalogs');

      final formDataMap = <String, dynamic>{};

      formDataMap['catalogType'] = params.catalogType;
      if (params.name != null) formDataMap['name'] = params.name;
      if (params.description != null) {
        formDataMap['description'] = params.description;
      }
      if (params.isPublic != null) {
        formDataMap['isPublic'] = MultipartHelper.encodeBool(params.isPublic!);
      }

      if (params.metadata != null) {
        formDataMap['metadata'] = MultipartHelper.encodeJson(params.metadata);
      }
      if (params.settings != null) {
        formDataMap['settings'] = MultipartHelper.encodeJson(params.settings);
      }

      if (params.tags != null && params.tags!.isNotEmpty) {
        formDataMap['tags'] = MultipartHelper.encodeTags(params.tags);
      }

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

      return CatalogModel.fromJson(
          _extractData(response.data) as Map<String, dynamic>);
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

      final responseData =
          _extractData(response.data) as Map<String, dynamic>;

      final linked = (responseData['linked'] as List<dynamic>?)
              ?.map((item) =>
                  CatalogModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [];
      final unlinked = (responseData['unlinked'] as List<dynamic>?)
              ?.map((item) =>
                  CatalogModel.fromJson(item as Map<String, dynamic>))
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
  Future<CatalogModel> getCatalogById(
    String catalogId, {
    int? offset,
    int? limit,
    bool inStock = true,
  }) async {
    try {
      final queryParams = <String, String>{};
      if (offset != null) queryParams['offset'] = offset.toString();
      if (limit != null) queryParams['limit'] = limit.toString();
      queryParams['inStock'] = inStock.toString();

      final uri = Uri.parse('${API.defaulBaseUrl}/catalogs/$catalogId')
          .replace(queryParameters: queryParams.isNotEmpty ? queryParams : null);

      final response = await _dio.get(
        uri.toString(),
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

      return CatalogModel.fromJson(
          _extractData(response.data) as Map<String, dynamic>);
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

      final formDataMap = <String, dynamic>{};

      if (params.name != null) formDataMap['name'] = params.name;
      if (params.description != null) {
        formDataMap['description'] = params.description;
      }
      if (params.status != null) formDataMap['status'] = params.status;
      if (params.slug != null) formDataMap['slug'] = params.slug;
      if (params.isPublic != null) {
        formDataMap['isPublic'] = MultipartHelper.encodeBool(params.isPublic!);
      }

      if (params.metadata != null) {
        formDataMap['metadata'] = MultipartHelper.encodeJson(params.metadata);
      }
      if (params.settings != null) {
        formDataMap['settings'] = MultipartHelper.encodeJson(params.settings);
      }

      if (params.tags != null && params.tags!.isNotEmpty) {
        formDataMap['tags'] = MultipartHelper.encodeTags(params.tags);
      }

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

      return CatalogModel.fromJson(
          _extractData(response.data) as Map<String, dynamic>);
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

      return _extractData(response.data) as Map<String, dynamic>;
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

      return CatalogModel.fromJson(
          _extractData(response.data) as Map<String, dynamic>);
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

      return CatalogModel.fromJson(
          _extractData(response.data) as Map<String, dynamic>);
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
  Future<CatalogModel> getPublicCatalogBySlug(
    String slug, {
    bool inStock = true,
  }) async {
    try {
      final queryParams = <String, String>{
        'inStock': inStock.toString(),
      };

      final uri = Uri.parse('${API.defaulBaseUrl}/catalogs/public/$slug')
          .replace(queryParameters: queryParams);

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

      return CatalogModel.fromJson(
          _extractData(response.data) as Map<String, dynamic>);
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
  Future<PaginatedCatalogsResult> searchPublicCatalogs({
    String? query,
    String? type,
    List<String>? tags,
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'offset': offset.toString(),
        'limit': limit.toString(),
      };
      if (query != null) queryParams['query'] = query;
      if (type != null) queryParams['type'] = type;
      if (tags != null && tags.isNotEmpty) queryParams['tags'] = tags.join(',');

      final uri = Uri.parse('${API.defaulBaseUrl}/catalogs/public/search')
          .replace(queryParameters: queryParams);

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

      final rawMap = _unwrapResponse(response.data);
      final pagination = rawMap.containsKey('pagination')
          ? PaginationModel.fromJson(
              rawMap['pagination'] as Map<String, dynamic>)
          : PaginationModel(total: 0, offset: offset, limit: limit, hasMore: false);

      final data = rawMap['data'] as List<dynamic>? ?? [];
      final items = data
          .map((item) => CatalogModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return PaginatedCatalogsResult(items: items, pagination: pagination);
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
  Future<CatalogModel> getPublicCatalogById(
    String catalogId, {
    bool inStock = true,
  }) async {
    try {
      final queryParams = <String, String>{
        'inStock': inStock.toString(),
      };

      final uri = Uri.parse('${API.defaulBaseUrl}/catalogs/public/id/$catalogId')
          .replace(queryParameters: queryParams);

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

      return CatalogModel.fromJson(
          _extractData(response.data) as Map<String, dynamic>);
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

      final data = _extractData(response.data);
      if (data is! List) {
        throw ApiException(500, 'Respuesta inválida del servidor');
      }

      return data
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
  Future<PaginatedCatalogsResult> getPublicCatalogsByCommerce(
    String identifier, {
    int offset = 0,
    int limit = 50,
    bool inStock = true,
  }) async {
    try {
      final queryParams = <String, String>{
        'offset': offset.toString(),
        'limit': limit.toString(),
        'inStock': inStock.toString(),
      };

      final uri = Uri.parse(
              '${API.defaulBaseUrl}/catalogs/public/commerce/$identifier')
          .replace(queryParameters: queryParams);

      final response = await _dio.get(
        uri.toString(),
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final rawMap = _unwrapResponse(response.data);
      final pagination = rawMap.containsKey('pagination')
          ? PaginationModel.fromJson(
              rawMap['pagination'] as Map<String, dynamic>)
          : PaginationModel(total: 0, offset: offset, limit: limit, hasMore: false);

      final data = rawMap['data'] as List<dynamic>? ?? [];
      final items = data
          .map((item) => CatalogModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return PaginatedCatalogsResult(items: items, pagination: pagination);
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
