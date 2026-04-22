import 'package:menu_dart_api/by_feature/payments/oauth/data/provider/mp_oauth_provider.dart';
import 'package:menu_dart_api/by_feature/payments/oauth/models/mp_oauth_base_response.dart';

/// Caso de uso para refrescar el token de acceso de Mercado Pago
///
/// Este caso de uso renueva automáticamente los tokens de acceso cuando
/// están por expirar o han expirado, manteniendo la vinculación activa.
///
/// Uso:
/// ```dart
/// final useCase = RefreshMPTokenUseCase();
/// final response = await useCase.execute();
/// if (response.success) {
///   print('Token refrescado exitosamente');
/// }
/// ```
class RefreshMPTokenUseCase {
  final MPOAuthProvider _provider;

  RefreshMPTokenUseCase({MPOAuthProvider? provider}) : _provider = provider ?? MPOAuthProvider();

  Future<MPOAuthBaseResponse> execute() async {
    try {
      return await _provider.refreshToken();
    } catch (e) {
      rethrow;
    }
  }

  /// Método helper para refrescar token de forma silenciosa
  /// Retorna true si se refrescó exitosamente, false en caso contrario
  Future<bool> executeSilently() async {
    try {
      final response = await execute();
      return response.success;
    } catch (e) {
      // Log el error si es necesario, pero no lo propagues
      return false;
    }
  }
}
