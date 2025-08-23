import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/app_data_model.dart';
import '../../models/create_app_data_params.dart';
import '../../models/update_app_data_params.dart';
import '../../../../core/exeptions/api_exception.dart';

class AppDataProvider {
  final http.Client client;
  final String baseUrl;

  AppDataProvider({
    required this.client,
    required this.baseUrl,
  });

  static const String _appDataEndpoint = '/app-data';

  /// Create a new app data entry
  Future<AppDataModel> createAppData(
    CreateAppDataParams params, {
    String? token,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$_appDataEndpoint');
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await client.post(
        uri,
        headers: headers,
        body: json.encode(params.toJson()),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return AppDataModel.fromJson(data);
      } else {
        throw ApiException(
          response.statusCode,
          'Failed to create app data: ${response.body}',
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        500,
        'Error creating app data: $e',
      );
    }
  }

  /// Get all app data entries
  Future<List<AppDataModel>> getAllAppData({String? token}) async {
    try {
      final uri = Uri.parse('$baseUrl$_appDataEndpoint');
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await client.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => AppDataModel.fromJson(json)).toList();
      } else {
        throw ApiException(
          response.statusCode,
          'Failed to get app data: ${response.body}',
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        500,
        'Error fetching app data: $e',
      );
    }
  }

  /// Get app data by ID
  Future<AppDataModel> getAppDataById(String id, {String? token}) async {
    try {
      final uri = Uri.parse('$baseUrl$_appDataEndpoint/$id');
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await client.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AppDataModel.fromJson(data);
      } else {
        throw ApiException(
          response.statusCode,
          'Failed to get app data by ID: ${response.body}',
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        500,
        'Error fetching app data by ID: $e',
      );
    }
  }

  /// Get app data by key
  Future<AppDataModel> getAppDataByKey(String key, {String? token}) async {
    try {
      final uri = Uri.parse('$baseUrl$_appDataEndpoint/key/$key');
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await client.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AppDataModel.fromJson(data);
      } else {
        throw ApiException(
          response.statusCode,
          'Failed to get app data by key: ${response.body}',
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        500,
        'Error fetching app data by key: $e',
      );
    }
  }

  /// Update an existing app data entry
  Future<AppDataModel> updateAppData(
    String id,
    UpdateAppDataParams params, {
    String? token,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$_appDataEndpoint/$id');
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await client.patch(
        uri,
        headers: headers,
        body: json.encode(params.toJson()),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AppDataModel.fromJson(data);
      } else {
        throw ApiException(
          response.statusCode,
          'Failed to update app data: ${response.body}',
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        500,
        'Error updating app data: $e',
      );
    }
  }

  /// Delete an app data entry
  Future<void> deleteAppData(String id, {String? token}) async {
    try {
      final uri = Uri.parse('$baseUrl$_appDataEndpoint/$id');
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await client.delete(uri, headers: headers);

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ApiException(
          response.statusCode,
          'Failed to delete app data: ${response.body}',
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        500,
        'Error deleting app data: $e',
      );
    }
  }

  /// Toggle the isActive status of an app data entry
  Future<AppDataModel> toggleAppData(String id, {String? token}) async {
    try {
      final uri = Uri.parse('$baseUrl$_appDataEndpoint/$id/toggle');
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await client.patch(uri, headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return AppDataModel.fromJson(data);
      } else {
        throw ApiException(
          response.statusCode,
          'Failed to toggle app data: ${response.body}',
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(
        500,
        'Error toggling app data: $e',
      );
    }
  }
}
