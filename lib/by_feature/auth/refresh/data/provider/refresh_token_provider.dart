import 'dart:convert';

import 'package:menu_dart_api/by_feature/auth/refresh/data/repository/refresh_token_repository.dart';
import 'package:menu_dart_api/by_feature/auth/refresh/model/refresh_token_response.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class RefreshTokenProvider extends RefreshTokenRepository {
  @override
  Future<RefreshTokenResponse> refreshToken() async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}/auth/refresh');
      final response = await API.httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        final errorData = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorData['message'] ?? 'Error al refrescar token',
        );
      }

      final responseData = jsonDecode(response.body);
      final refreshResponse = RefreshTokenResponse.fromJson(responseData);

      API.setAccessToken(refreshResponse.accessToken);

      return refreshResponse;
    } catch (e) {
      rethrow;
    }
  }
}
