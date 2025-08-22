import 'package:menu_dart_api/by_feature/payments/oauth/data/provider/mp_oauth_provider.dart';
import 'package:menu_dart_api/by_feature/payments/oauth/models/mp_oauth_base_response.dart';
import 'package:menu_dart_api/by_feature/payments/oauth/models/mp_oauth_callback_request.dart';

/// Caso de uso para completar la vinculación OAuth con Mercado Pago
///
/// Este caso de uso procesa el código de autorización recibido de Mercado Pago
/// después de que el usuario autorice la aplicación y complete la vinculación.
///
/// Uso:
/// ```dart
/// final useCase = CompleteMPOAuthUseCase();
/// final request = MPOAuthCallbackRequest(
///   authorizationCode: 'codigo_recibido_de_mp',
///   redirectUri: 'https://tuapp.com/oauth/callback',
/// );
/// final response = await useCase.execute(request);
/// if (response.success) {
///   // Cuenta vinculada exitosamente
/// }
/// ```
class CompleteMPOAuthUseCase {
  final MPOAuthProvider _provider;

  CompleteMPOAuthUseCase({MPOAuthProvider? provider}) : _provider = provider ?? MPOAuthProvider();

  Future<MPOAuthBaseResponse> execute(MPOAuthCallbackRequest request) async {
    try {
      // Validar que el código de autorización no esté vacío
      if (request.authorizationCode.isEmpty) {
        throw ArgumentError('Authorization code cannot be empty');
      }

      // Validar que el redirect URI no esté vacío
      if (request.redirectUri.isEmpty) {
        throw ArgumentError('Redirect URI cannot be empty');
      }

      return await _provider.completeOAuth(request);
    } catch (e) {
      rethrow;
    }
  }

  /// Método helper para crear una solicitud desde parámetros de URL
  MPOAuthCallbackRequest createRequestFromUrlParams({
    required String authorizationCode,
    required String redirectUri,
  }) {
    return MPOAuthCallbackRequest(
      authorizationCode: authorizationCode,
      redirectUri: redirectUri,
    );
  }
}
