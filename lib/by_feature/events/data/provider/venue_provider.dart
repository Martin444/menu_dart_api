import 'dart:convert';

import 'package:menu_dart_api/by_feature/events/data/repository/venue_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/venue_model.dart';
import 'package:menu_dart_api/by_feature/events/models/create_venue_params.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class VenueProvider extends VenueRepository {
  @override
  Future<VenueModel> create(CreateVenueParams params) async {
    try {
      final url = Uri.parse('${API.defaulBaseUrl}/venues');
      final response = await API.httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
        body: jsonEncode(params.toJson()),
      );
      if (response.statusCode != 201 && response.statusCode != 200) {
        throw ApiException(response.statusCode, response.body);
      }
      final decoded = jsonDecode(response.body);
      final data = decoded is Map<String, dynamic>
          ? (decoded['data'] ?? decoded)
          : decoded;
      return VenueModel.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }

  @override
  Future<List<VenueModel>> list() async {
    try {
      final url = Uri.parse('${API.defaulBaseUrl}/venues');
      final response = await API.httpClient.get(url);
      if (response.statusCode != 200) {
        throw ApiException(response.statusCode, response.body);
      }
      final decoded = jsonDecode(response.body);
      final data = decoded is List
          ? decoded
          : (decoded is Map<String, dynamic> ? (decoded['data'] ?? decoded) : decoded);
      if (data is! List) {
        throw ApiException(500, 'Respuesta inesperada del servidor');
      }
      return data
          .map((e) => VenueModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }

  @override
  Future<VenueModel> getById(String id) async {
    try {
      final url = Uri.parse('${API.defaulBaseUrl}/venues/$id');
      final response = await API.httpClient.get(url);
      if (response.statusCode != 200) {
        throw ApiException(response.statusCode, response.body);
      }
      final decoded = jsonDecode(response.body);
      final data = decoded is Map<String, dynamic>
          ? (decoded['data'] ?? decoded)
          : decoded;
      return VenueModel.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      final url = Uri.parse('${API.defaulBaseUrl}/venues/$id');
      final response = await API.httpClient.delete(
        url,
        headers: {
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
      );
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ApiException(response.statusCode, response.body);
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }
}
