import 'dart:convert';
import 'dart:typed_data';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:menu_dart_api/by_feature/commerce/data/repository/commerce_repository.dart';
import 'package:menu_dart_api/by_feature/commerce/models/commerce.dart';
import 'package:menu_dart_api/by_feature/commerce/models/commerce_requests.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';
import 'package:menu_dart_api/core/helpers/multipart_helper.dart';

class CommerceProvider extends CommerceRepository {
  static const String _basePath = '/commerce';

  void _addFields(http.MultipartRequest request, Map<String, dynamic> fields) {
    fields.forEach((key, value) {
      if (value != null) {
        if (value is Map) {
          request.fields[key] = MultipartHelper.encodeJson(value as Map<String, dynamic>) ?? '';
        } else {
          request.fields[key] = value.toString();
        }
      }
    });
  }

  void _addFile(http.MultipartRequest request, String fieldName, Uint8List? bytes) {
    if (bytes == null || bytes.isEmpty) return;
    request.files.add(
      http.MultipartFile.fromBytes(
        fieldName,
        bytes,
        filename: '${fieldName}_${DateTime.now().millisecondsSinceEpoch}.jpg',
      ),
    );
  }

  @override
  Future<Commerce> create(CreateCommerceRequest request) async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}$_basePath');
      var multipartRequest = http.MultipartRequest('POST', url);
      multipartRequest.headers['Authorization'] = 'Bearer ${API.loginAccessToken}';

      _addFields(multipartRequest, request.toJson());
      _addFile(multipartRequest, 'logo', request.logoBytes);
      _addFile(multipartRequest, 'coverImage', request.coverImageBytes);

      var streamedResponse = await multipartRequest.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 201) {
        final errorData = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorData['message'] ?? 'Error al crear comercio',
        );
      }

      final data = jsonDecode(response.body);
      return Commerce.fromJson(
        data is Map<String, dynamic> && data['data'] is Map<String, dynamic>
            ? data['data'] as Map<String, dynamic>
            : data as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Commerce>> getMyCommerces() async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}$_basePath/my');
      final response = await API.httpClient.get(
        url,
        headers: {'Authorization': 'Bearer ${API.loginAccessToken}'},
      );

      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorData['message'] ?? 'Error al obtener comercios',
        );
      }

      final decoded = jsonDecode(response.body);
      final List<dynamic> list = decoded is List ? decoded : (decoded['data'] as List<dynamic>? ?? []);
      return list.map((e) => Commerce.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Commerce> getById(String commerceId) async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}$_basePath/$commerceId');
      final response = await API.httpClient.get(
        url,
        headers: {'Authorization': 'Bearer ${API.loginAccessToken}'},
      );

      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorData['message'] ?? 'Error al obtener comercio',
        );
      }

      final data = jsonDecode(response.body);
      return Commerce.fromJson(
        data is Map<String, dynamic> && data['data'] is Map<String, dynamic>
            ? data['data'] as Map<String, dynamic>
            : data as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Commerce> update(String commerceId, UpdateCommerceRequest request) async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}$_basePath/$commerceId');
      var multipartRequest = http.MultipartRequest('PUT', url);
      multipartRequest.headers['Authorization'] = 'Bearer ${API.loginAccessToken}';

      _addFields(multipartRequest, request.toJson());
      _addFile(multipartRequest, 'logo', request.logoBytes);
      _addFile(multipartRequest, 'coverImage', request.coverImageBytes);

      var streamedResponse = await multipartRequest.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorData['message'] ?? 'Error al actualizar comercio',
        );
      }

      final data = jsonDecode(response.body);
      return Commerce.fromJson(
        data is Map<String, dynamic> && data['data'] is Map<String, dynamic>
            ? data['data'] as Map<String, dynamic>
            : data as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String commerceId) async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}$_basePath/$commerceId');
      final response = await API.httpClient.delete(
        url,
        headers: {'Authorization': 'Bearer ${API.loginAccessToken}'},
      );

      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorData['message'] ?? 'Error al eliminar comercio',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
