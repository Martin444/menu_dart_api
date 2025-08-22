import 'package:menu_dart_api/by_feature/payments/oauth/data/provider/mp_oauth_provider.dart';
import 'package:menu_dart_api/by_feature/payments/oauth/models/mp_oauth_base_response.dart';

/// Caso de uso para desvincular la cuenta de Mercado Pago
///
/// Este caso de uso permite al usuario desvincular su cuenta de Mercado Pago
/// de la aplicación, revocando todos los permisos y tokens asociados.
///
/// Uso:
/// ```dart
/// final useCase = UnlinkMPAccountUseCase();
/// final response = await useCase.execute();
/// if (response.success) {
///   print('Cuenta desvinculada exitosamente');
/// }
/// ```
class UnlinkMPAccountUseCase {
  final MPOAuthProvider _provider;

  UnlinkMPAccountUseCase({MPOAuthProvider? provider}) : _provider = provider ?? MPOAuthProvider();

  Future<MPOAuthBaseResponse> execute() async {
    try {
      return await _provider.unlinkAccount();
    } catch (e) {
      rethrow;
    }
  }

  /// Método helper para desvincular con confirmación adicional
  Future<MPOAuthBaseResponse> executeWithConfirmation({
    required bool confirmed,
  }) async {
    if (!confirmed) {
      throw ArgumentError('User confirmation is required to unlink account');
    }

    return await execute();
  }
}
