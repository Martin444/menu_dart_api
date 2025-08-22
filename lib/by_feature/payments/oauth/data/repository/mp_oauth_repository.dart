import 'package:menu_dart_api/by_feature/payments/oauth/models/mp_oauth_base_response.dart';
import 'package:menu_dart_api/by_feature/payments/oauth/models/mp_oauth_callback_request.dart';
import 'package:menu_dart_api/by_feature/payments/oauth/models/mp_oauth_initiate_request.dart';
import 'package:menu_dart_api/by_feature/payments/oauth/models/mp_oauth_initiate_response.dart';
import 'package:menu_dart_api/by_feature/payments/oauth/models/mp_oauth_status_response.dart';

abstract class MPOAuthRepository {
  /// Iniciar proceso de vinculación OAuth con Mercado Pago
  Future<MPOAuthInitiateResponse> initiateOAuth(MPOAuthInitiateRequest request);

  /// Completar vinculación OAuth con el código de autorización
  Future<MPOAuthBaseResponse> completeOAuth(MPOAuthCallbackRequest request);

  /// Verificar estado de vinculación de la cuenta
  Future<MPOAuthStatusResponse> getOAuthStatus();

  /// Desvincular cuenta de Mercado Pago
  Future<MPOAuthBaseResponse> unlinkAccount();

  /// Refrescar token de acceso
  Future<MPOAuthBaseResponse> refreshToken();
}
