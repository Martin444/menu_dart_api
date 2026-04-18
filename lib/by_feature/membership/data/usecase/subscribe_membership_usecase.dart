import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/models/membership_status_model.dart';

/// Caso de uso para suscribirse a un plan (sin pago, e.g. FREE)
class SubscribeMembershipUseCase {
  final MembershipProvider _provider = MembershipProvider();

  /// Suscribe al usuario al plan indicado
  ///
  /// [plan] - El plan al que se quiere suscribir (FREE, PREMIUM, ENTERPRISE)
  ///
  /// Retorna [MembershipStatusModel] con el estado actualizado
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<MembershipStatusModel> execute(String plan) async {
    try {
      return await _provider.subscribe(plan);
    } catch (e) {
      rethrow;
    }
  }
}
