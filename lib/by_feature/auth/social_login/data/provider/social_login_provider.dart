import 'dart:convert';

import 'package:menu_dart_api/by_feature/auth/social_login/data/repository/social_login_repository.dart';
import 'package:menu_dart_api/by_feature/auth/social_login/model/social_login_request.dart';
import 'package:menu_dart_api/by_feature/auth/social_login/model/social_login_response.dart';
import 'package:menu_dart_api/by_feature/auth/social_login/model/social_register_request.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

/// Implementación del proveedor de datos para autenticación social.
///
/// Maneja la comunicación HTTP con los endpoints /auth/social/login
/// y /auth/social/register del backend.
class SocialLoginProvider extends SocialLoginRepository {
  static const String _socialLoginEndpoint = '/auth/social/login';
  static const String _socialRegisterEndpoint = '/auth/social/register';

  @override
  Future<SocialLoginResponse> loginWithFirebaseToken(SocialLoginRequest request) async {
    try {
      final Uri socialLoginUrl = Uri.parse('${API.defaulBaseUrl}$_socialLoginEndpoint');

      final response = await API.httpClient.post(
        socialLoginUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${request.firebaseIdToken}',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        final errorData = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorData['message'] ?? 'Error en autenticación social',
        );
      }

      final responseData = jsonDecode(response.body);
      final socialLoginResponse = SocialLoginResponse.fromJson(responseData);

      API.setAccessToken(socialLoginResponse.accessToken);

      return socialLoginResponse;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SocialLoginResponse> registerWithFirebaseToken({
    required String firebaseIdToken,
    required SocialRegisterRequest request,
  }) async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}$_socialRegisterEndpoint');

      final response = await API.httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $firebaseIdToken',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        final errorData = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorData['message'] ?? 'Error en registro social',
        );
      }

      final responseData = jsonDecode(response.body);
      final socialLoginResponse = SocialLoginResponse.fromJson(responseData);

      API.setAccessToken(socialLoginResponse.accessToken);

      return socialLoginResponse;
    } catch (e) {
      rethrow;
    }
  }
}
