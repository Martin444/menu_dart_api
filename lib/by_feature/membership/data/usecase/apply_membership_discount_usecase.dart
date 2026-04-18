import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/models/discount_result_model.dart';

/// Caso de uso para aplicar un código de descuento
class ApplyMembershipDiscountUseCase {
  final MembershipProvider _provider = MembershipProvider();

  /// Aplica un código de descuento a la membresía actual
  ///
  /// [code] - El código de descuento a validar y aplicar
  ///
  /// Retorna [DiscountResultModel] con el resultado de la validación
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<DiscountResultModel> execute(String code) async {
    try {
      return await _provider.applyDiscount(code);
    } catch (e) {
      rethrow;
    }
  }
}
