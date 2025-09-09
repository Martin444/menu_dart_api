import 'package:menu_dart_api/by_feature/auth/social_login/data/provider/social_login_provider.dart';
import 'package:menu_dart_api/by_feature/auth/social_login/data/repository/social_login_repository.dart';
import 'package:menu_dart_api/by_feature/auth/social_login/model/social_login_request.dart';
import 'package:menu_dart_api/by_feature/auth/social_login/model/social_login_response.dart';

/// Caso de uso para la autenticación social con Firebase.
///
/// Maneja el flujo de autenticación social integrando el token
/// de Firebase con el backend del sistema para obtener un JWT válido.
class SocialLoginUseCase {
  final SocialLoginRepository _repository;

  /// Constructor que acepta un repositorio personalizado para testing
  SocialLoginUseCase([SocialLoginRepository? repository]) : _repository = repository ?? SocialLoginProvider();

  /// Ejecuta el login social usando un token de Firebase ID.
  ///
  /// Este caso de uso:
  /// 1. Valida el token de entrada
  /// 2. Envía el token al backend para verificación
  /// 3. Retorna la respuesta con el JWT del sistema
  ///
  /// Parámetros:
  /// - [firebaseIdToken]: Token de ID obtenido de Firebase Auth
  /// - [additionalData]: Datos adicionales opcionales del usuario
  ///
  /// Retorna:
  /// - [SocialLoginResponse] con el token de acceso y datos del usuario
  ///
  /// Excepciones:
  /// - [ArgumentError] si el token está vacío
  /// - [ApiException] si hay errores en la comunicación con el backend
  Future<SocialLoginResponse> execute({
    required String firebaseIdToken,
    Map<String, dynamic>? additionalData,
  }) async {
    // Validar parámetros de entrada
    if (firebaseIdToken.isEmpty) {
      throw ArgumentError('El token de Firebase no puede estar vacío');
    }

    // Crear la solicitud
    final request = SocialLoginRequest(
      firebaseIdToken: firebaseIdToken,
      additionalData: additionalData,
    );

    // Ejecutar la autenticación
    return await _repository.loginWithFirebaseToken(request);
  }

  /// Método de conveniencia para login con Google.
  ///
  /// Wrapper específico para autenticaciones con Google Sign-In.
  Future<SocialLoginResponse> executeWithGoogle({
    required String firebaseIdToken,
    Map<String, dynamic>? userInfo,
  }) async {
    final additionalData = <String, dynamic>{
      'provider': 'google',
      if (userInfo != null) ...userInfo,
    };

    return await execute(
      firebaseIdToken: firebaseIdToken,
      additionalData: additionalData,
    );
  }

  /// Método de conveniencia para login con Apple.
  ///
  /// Wrapper específico para autenticaciones con Apple Sign-In.
  Future<SocialLoginResponse> executeWithApple({
    required String firebaseIdToken,
    Map<String, dynamic>? userInfo,
  }) async {
    final additionalData = <String, dynamic>{
      'provider': 'apple',
      if (userInfo != null) ...userInfo,
    };

    return await execute(
      firebaseIdToken: firebaseIdToken,
      additionalData: additionalData,
    );
  }
}
