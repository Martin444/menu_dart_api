import 'package:menu_dart_api/by_feature/payments/oauth/data/provider/mp_oauth_provider.dart';
import 'package:menu_dart_api/by_feature/payments/oauth/models/mp_oauth_status_response.dart';

/// Caso de uso para verificar el estado de vinculación OAuth con Mercado Pago
///
/// Este caso de uso permite verificar si el usuario tiene una cuenta de Mercado Pago
/// vinculada y obtener información básica de la cuenta.
///
/// Uso:
/// ```dart
/// final useCase = GetMPOAuthStatusUseCase();
/// final status = await useCase.execute();
/// if (status.isLinked) {
///   print('Cuenta vinculada: ${status.account?.email}');
/// } else {
///   print('No hay cuenta vinculada');
/// }
/// ```
class GetMPOAuthStatusUseCase {
  final MPOAuthProvider _provider;

  GetMPOAuthStatusUseCase({MPOAuthProvider? provider}) : _provider = provider ?? MPOAuthProvider();

  Future<MPOAuthStatusResponse> execute() async {
    try {
      return await _provider.getOAuthStatus();
    } catch (e) {
      rethrow;
    }
  }

  /// Método helper para verificar solo si está vinculado
  Future<bool> isAccountLinked() async {
    try {
      final status = await execute();
      return status.isLinked;
    } catch (e) {
      // En caso de error, asumimos que no está vinculado
      return false;
    }
  }

  /// Método helper para obtener información de la cuenta si está vinculada
  Future<String?> getLinkedAccountEmail() async {
    try {
      final status = await execute();
      return status.isLinked ? status.account?.email : null;
    } catch (e) {
      return null;
    }
  }
}
