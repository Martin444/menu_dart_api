import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/models/payment_result_model.dart';

/// Caso de uso para crear un pago de membresía en MercadoPago
class CreateMembershipPaymentUseCase {
  final MembershipProvider _provider = MembershipProvider();

  /// Crea un pago para el plan especificado
  ///
  /// [plan] - El план al que se quiere suscribir (PREMIUM, ENTERPRISE)
  ///
  /// Retorna [PaymentResultModel] con la URL de pago para redirigir al usuario
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<PaymentResultModel> execute(String plan) async {
    try {
      return await _provider.createPayment(plan);
    } catch (e) {
      rethrow;
    }
  }
}
