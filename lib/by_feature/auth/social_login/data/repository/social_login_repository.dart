import 'package:menu_dart_api/by_feature/auth/social_login/model/social_login_request.dart';
import 'package:menu_dart_api/by_feature/auth/social_login/model/social_login_response.dart';

/// Contrato del repositorio para autenticación social.
///
/// Define la interfaz para la comunicación con el endpoint
/// de social login del backend.
abstract class SocialLoginRepository {
  /// Autentica un usuario usando un token de Firebase ID.
  ///
  /// Envía el token de Firebase obtenido del sign-in social
  /// al endpoint /auth/social/login para validación y obtención
  /// del JWT del sistema.
  ///
  /// Parámetros:
  /// - [request]: Datos de la solicitud incluyendo el firebaseIdToken
  ///
  /// Retorna:
  /// - [SocialLoginResponse] con el token de acceso y datos del usuario
  ///
  /// Excepciones:
  /// - [ApiException] si el token es inválido o hay errores del servidor
  Future<SocialLoginResponse> loginWithFirebaseToken(SocialLoginRequest request);
}
