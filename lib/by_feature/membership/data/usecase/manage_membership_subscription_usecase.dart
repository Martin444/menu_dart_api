import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';

/// Caso de uso para gestionar el estado de la suscripción (pausar, reanudar, cancelar)
class ManageMembershipSubscriptionUseCase {
  final MembershipProvider _provider = MembershipProvider();

  /// Pausa la suscripción activa
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<bool> pause() async {
    try {
      return await _provider.pauseSubscription();
    } catch (e) {
      rethrow;
    }
  }

  /// Reanuda una suscripción pausada
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<bool> resume() async {
    try {
      return await _provider.resumeSubscription();
    } catch (e) {
      rethrow;
    }
  }

  /// Cancela la suscripción activa
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<bool> cancel() async {
    try {
      return await _provider.cancelSubscription();
    } catch (e) {
      rethrow;
    }
  }
}
