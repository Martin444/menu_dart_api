import 'package:menu_dart_api/by_feature/payments/oauth/data/provider/mp_oauth_provider.dart';
import 'package:menu_dart_api/by_feature/payments/oauth/models/mp_oauth_initiate_request.dart';
import 'package:menu_dart_api/by_feature/payments/oauth/models/mp_oauth_initiate_response.dart';

/// Caso de uso para iniciar el proceso de OAuth con Mercado Pago
///
/// Este caso de uso genera una URL de autorización para que el usuario
/// pueda vincular su cuenta de Mercado Pago con la aplicación.
///
/// Uso:
/// ```dart
/// final useCase = InitiateMPOAuthUseCase();
/// final request = MPOAuthInitiateRequest(
///   redirectUri: 'https://tuapp.com/oauth/callback',
///   state: 'user_123_security_token',
/// );
/// final response = await useCase.execute(request);
/// // Redirigir al usuario a response.authorizationUrl
/// ```
class InitiateMPOAuthUseCase {
  final MPOAuthProvider _provider;

  InitiateMPOAuthUseCase({MPOAuthProvider? provider}) : _provider = provider ?? MPOAuthProvider();

  Future<MPOAuthInitiateResponse> execute(MPOAuthInitiateRequest request) async {
    try {
      return await _provider.initiateOAuth(request);
    } catch (e) {
      rethrow;
    }
  }

  /// Método helper para crear una solicitud con estado automático
  MPOAuthInitiateRequest createRequest({
    required String redirectUri,
    String? customState,
  }) {
    final state = customState ?? 'oauth_${DateTime.now().millisecondsSinceEpoch}';

    return MPOAuthInitiateRequest(
      redirectUri: redirectUri,
      state: state,
    );
  }
}
