import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/models/membership_plan_model.dart';

/// Caso de uso para obtener los planes de membresía disponibles
class GetMembershipPlansUseCase {
  final MembershipProvider _provider = MembershipProvider();

  /// Ejecuta la obtención de planes disponibles
  ///
  /// Retorna lista de [MembershipPlanModel]
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<List<MembershipPlanModel>> execute() async {
    try {
      return await _provider.getAvailablePlans();
    } catch (e) {
      rethrow;
    }
  }
}
