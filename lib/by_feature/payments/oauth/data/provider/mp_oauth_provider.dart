import 'dart:convert';
import 'package:menu_dart_api/by_feature/payments/oauth/data/repository/mp_oauth_repository.dart';
import 'package:menu_dart_api/by_feature/payments/oauth/models/mp_oauth_base_response.dart';
import 'package:menu_dart_api/by_feature/payments/oauth/models/mp_oauth_callback_request.dart';
import 'package:menu_dart_api/by_feature/payments/oauth/models/mp_oauth_initiate_request.dart';
import 'package:menu_dart_api/by_feature/payments/oauth/models/mp_oauth_initiate_response.dart';
import 'package:menu_dart_api/by_feature/payments/oauth/models/mp_oauth_status_response.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class MPOAuthProvider extends MPOAuthRepository {
  static const String _baseEndpoint = '/payments/oauth';

  @override
  Future<MPOAuthInitiateResponse> initiateOAuth(MPOAuthInitiateRequest request) async {
    try {
      Uri url = Uri.parse('${API.defaulBaseUrl}$_baseEndpoint/initiate');

      var response = await API.httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        var errorResponse = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorResponse['message'] ?? 'Error al iniciar OAuth',
        );
      }

      var responseData = jsonDecode(response.body);
      var data = responseData['data'] ?? responseData;
      return MPOAuthInitiateResponse.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MPOAuthBaseResponse> completeOAuth(MPOAuthCallbackRequest request) async {
    try {
      Uri url = Uri.parse('${API.defaulBaseUrl}$_baseEndpoint/callback');

      var response = await API.httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        var errorResponse = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorResponse['message'] ?? 'Error al completar OAuth',
        );
      }

      var responseData = jsonDecode(response.body);
      var data = responseData['data'] ?? responseData;
      return MPOAuthBaseResponse.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MPOAuthStatusResponse> getOAuthStatus() async {
    try {
      Uri url = Uri.parse('${API.defaulBaseUrl}$_baseEndpoint/status');

      var response = await API.httpClient.get(
        url,
        headers: {
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
      );

      if (response.statusCode != 200) {
        var errorResponse = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorResponse['message'] ?? 'Error al obtener estado OAuth',
        );
      }

      var responseData = jsonDecode(response.body);
      var data = responseData['data'] ?? responseData;
      return MPOAuthStatusResponse.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MPOAuthBaseResponse> unlinkAccount() async {
    try {
      Uri url = Uri.parse('${API.defaulBaseUrl}$_baseEndpoint/unlink');

      var response = await API.httpClient.post(
        url,
        headers: {
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        var errorResponse = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorResponse['message'] ?? 'Error al desvincular cuenta',
        );
      }

      var responseData = jsonDecode(response.body);
      var data = responseData['data'] ?? responseData;
      return MPOAuthBaseResponse.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MPOAuthBaseResponse> refreshToken() async {
    try {
      Uri url = Uri.parse('${API.defaulBaseUrl}$_baseEndpoint/refresh-token');

      var response = await API.httpClient.post(
        url,
        headers: {
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        var errorResponse = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorResponse['message'] ?? 'Error al refrescar token',
        );
      }

      var responseData = jsonDecode(response.body);
      var data = responseData['data'] ?? responseData;
      return MPOAuthBaseResponse.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
