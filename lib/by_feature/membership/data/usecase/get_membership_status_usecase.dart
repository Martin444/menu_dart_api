import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/models/membership_status_model.dart';

/// Caso de uso para obtener el estado de la membresía
class GetMembershipStatusUseCase {
  final MembershipProvider _provider = MembershipProvider();

  /// Ejecuta la obtención del estado de membresía del usuario autenticado
  ///
  /// Retorna [MembershipStatusModel] con el estado actual
  /// Si el usuario no tiene membresía (404), retorna un modelo FREE
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<MembershipStatusModel> execute() async {
    try {
      return await _provider.getMembershipStatus();
    } catch (e) {
      rethrow;
    }
  }
}
