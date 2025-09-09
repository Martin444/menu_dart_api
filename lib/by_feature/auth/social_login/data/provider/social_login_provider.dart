import 'dart:convert';

import 'package:menu_dart_api/by_feature/auth/social_login/data/repository/social_login_repository.dart';
import 'package:menu_dart_api/by_feature/auth/social_login/model/social_login_request.dart';
import 'package:menu_dart_api/by_feature/auth/social_login/model/social_login_response.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

/// Implementación del proveedor de datos para autenticación social.
///
/// Maneja la comunicación HTTP con el endpoint /auth/social/login
/// del backend para validar tokens de Firebase y obtener JWTs del sistema.
class SocialLoginProvider extends SocialLoginRepository {
  static const String _socialLoginEndpoint = '/auth/social/login';

  @override
  Future<SocialLoginResponse> loginWithFirebaseToken(SocialLoginRequest request) async {
    try {
      final Uri socialLoginUrl = Uri.parse('${API.defaulBaseUrl}$_socialLoginEndpoint');

      // Realizar petición POST con el token de Firebase
      final response = await API.httpClient.post(
        socialLoginUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${request.firebaseIdToken}',
        },
        body: jsonEncode(request.toJson()),
      );

      // Verificar el status code de respuesta
      if (response.statusCode != 200 && response.statusCode != 201) {
        final errorData = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorData['message'] ?? 'Error en autenticación social',
        );
      }

      // Parsear respuesta exitosa
      final responseData = jsonDecode(response.body);
      final socialLoginResponse = SocialLoginResponse.fromJson(responseData);

      // Configurar el token de acceso en la API
      API.setAccessToken(socialLoginResponse.accessToken);

      return socialLoginResponse;
    } catch (e) {
      // Re-lanzar excepción para manejo en capas superiores
      rethrow;
    }
  }
}
