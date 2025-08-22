import 'package:menu_dart_api/by_feature/payments/oauth/data/usescase/mp_oauth_usecases.dart';
import 'package:menu_dart_api/by_feature/payments/oauth/models/mp_oauth_models.dart';

/// Servicio de alto nivel para manejar OAuth de Mercado Pago
///
/// Este servicio encapsula todos los casos de uso relacionados con OAuth
/// y proporciona una interfaz simplificada para la vinculación de cuentas.
///
/// Uso:
/// ```dart
/// final service = MPOAuthService();
///
/// // 1. Verificar estado actual
/// final isLinked = await service.isAccountLinked();
///
/// // 2. Iniciar vinculación
/// final authUrl = await service.startLinking('https://tuapp.com/callback');
///
/// // 3. Completar vinculación
/// await service.completeLinking(authCode, 'https://tuapp.com/callback');
///
/// // 4. Desvincular si es necesario
/// await service.unlinkAccount();
/// ```
class MPOAuthService {
  final InitiateMPOAuthUseCase _initiateUseCase;
  final CompleteMPOAuthUseCase _completeUseCase;
  final GetMPOAuthStatusUseCase _statusUseCase;
  final UnlinkMPAccountUseCase _unlinkUseCase;
  final RefreshMPTokenUseCase _refreshUseCase;

  MPOAuthService({
    InitiateMPOAuthUseCase? initiateUseCase,
    CompleteMPOAuthUseCase? completeUseCase,
    GetMPOAuthStatusUseCase? statusUseCase,
    UnlinkMPAccountUseCase? unlinkUseCase,
    RefreshMPTokenUseCase? refreshUseCase,
  })  : _initiateUseCase = initiateUseCase ?? InitiateMPOAuthUseCase(),
        _completeUseCase = completeUseCase ?? CompleteMPOAuthUseCase(),
        _statusUseCase = statusUseCase ?? GetMPOAuthStatusUseCase(),
        _unlinkUseCase = unlinkUseCase ?? UnlinkMPAccountUseCase(),
        _refreshUseCase = refreshUseCase ?? RefreshMPTokenUseCase();

  /// Verificar si hay una cuenta vinculada
  Future<bool> isAccountLinked() async {
    return await _statusUseCase.isAccountLinked();
  }

  /// Obtener información completa del estado de vinculación
  Future<MPOAuthStatusResponse> getAccountStatus() async {
    return await _statusUseCase.execute();
  }

  /// Obtener email de la cuenta vinculada (si existe)
  Future<String?> getLinkedAccountEmail() async {
    return await _statusUseCase.getLinkedAccountEmail();
  }

  /// Iniciar proceso de vinculación OAuth
  /// Retorna la URL a la que se debe redirigir al usuario
  Future<String> startLinking(String redirectUri, {String? customState}) async {
    final request = _initiateUseCase.createRequest(
      redirectUri: redirectUri,
      customState: customState,
    );

    final response = await _initiateUseCase.execute(request);
    return response.authorizationUrl;
  }

  /// Completar vinculación con el código de autorización recibido
  Future<bool> completeLinking(String authorizationCode, String redirectUri) async {
    final request = _completeUseCase.createRequestFromUrlParams(
      authorizationCode: authorizationCode,
      redirectUri: redirectUri,
    );

    final response = await _completeUseCase.execute(request);
    return response.success;
  }

  /// Desvincular cuenta de Mercado Pago
  Future<bool> unlinkAccount({bool requireConfirmation = true}) async {
    if (requireConfirmation) {
      final response = await _unlinkUseCase.executeWithConfirmation(
        confirmed: true,
      );
      return response.success;
    } else {
      final response = await _unlinkUseCase.execute();
      return response.success;
    }
  }

  /// Refrescar token de acceso
  Future<bool> refreshToken() async {
    final response = await _refreshUseCase.execute();
    return response.success;
  }

  /// Refrescar token de forma silenciosa (sin lanzar excepciones)
  Future<bool> refreshTokenSilently() async {
    return await _refreshUseCase.executeSilently();
  }

  /// Flujo completo de vinculación (helper method)
  ///
  /// Este método combina la verificación de estado y el inicio de vinculación
  Future<LinkingFlowResult> initiateLinkingFlow(String redirectUri) async {
    try {
      // Verificar si ya está vinculado
      final isLinked = await isAccountLinked();
      if (isLinked) {
        final account = await getAccountStatus();
        return LinkingFlowResult.alreadyLinked(account.account?.email);
      }

      // Iniciar proceso de vinculación
      final authUrl = await startLinking(redirectUri);
      return LinkingFlowResult.authUrlGenerated(authUrl);
    } catch (e) {
      return LinkingFlowResult.error(e.toString());
    }
  }

  /// Verificar y refrescar token automáticamente si es necesario
  Future<bool> ensureValidToken() async {
    try {
      // Primero verificar si hay cuenta vinculada
      final status = await getAccountStatus();
      if (!status.isLinked) {
        return false;
      }

      // Intentar refrescar token silenciosamente
      return await refreshTokenSilently();
    } catch (e) {
      return false;
    }
  }
}

/// Resultado del flujo de vinculación
class LinkingFlowResult {
  final LinkingFlowStatus status;
  final String? data;
  final String? error;

  LinkingFlowResult._(this.status, this.data, this.error);

  factory LinkingFlowResult.alreadyLinked(String? email) {
    return LinkingFlowResult._(
      LinkingFlowStatus.alreadyLinked,
      email,
      null,
    );
  }

  factory LinkingFlowResult.authUrlGenerated(String url) {
    return LinkingFlowResult._(
      LinkingFlowStatus.authUrlGenerated,
      url,
      null,
    );
  }

  factory LinkingFlowResult.error(String error) {
    return LinkingFlowResult._(
      LinkingFlowStatus.error,
      null,
      error,
    );
  }

  bool get isSuccess => status != LinkingFlowStatus.error;
  bool get isAlreadyLinked => status == LinkingFlowStatus.alreadyLinked;
  bool get hasAuthUrl => status == LinkingFlowStatus.authUrlGenerated;
  String? get authUrl => hasAuthUrl ? data : null;
  String? get linkedEmail => isAlreadyLinked ? data : null;
}

enum LinkingFlowStatus {
  alreadyLinked,
  authUrlGenerated,
  error,
}
