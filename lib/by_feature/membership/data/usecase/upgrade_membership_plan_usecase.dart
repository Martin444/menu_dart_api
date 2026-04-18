import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/models/membership_status_model.dart';

/// Caso de uso para actualizar/hacer upgrade de plan
class UpgradeMembershipPlanUseCase {
  final MembershipProvider _provider = MembershipProvider();

  /// Actualiza el plan de membresía del usuario
  ///
  /// [newPlan] - El nuevo plan (PREMIUM, ENTERPRISE)
  ///
  /// Retorna [MembershipStatusModel] con el estado actualizado
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<MembershipStatusModel> execute(String newPlan) async {
    try {
      return await _provider.upgradePlan(newPlan);
    } catch (e) {
      rethrow;
    }
  }
}
