import 'package:menu_dart_api/by_feature/membership/models/membership_status_model.dart';
import 'package:menu_dart_api/by_feature/membership/models/membership_plan_model.dart';
import 'package:menu_dart_api/by_feature/membership/models/discount_result_model.dart';
import 'package:menu_dart_api/by_feature/membership/models/payment_result_model.dart';

/// Repositorio abstracto para operaciones de membresía
abstract class MembershipRepository {
  /// Obtiene el estado actual de la membresía
  Future<MembershipStatusModel> getMembershipStatus();

  /// Obtiene los planes disponibles
  Future<List<MembershipPlanModel>> getAvailablePlans();

  /// Obtiene los planes personalizados
  Future<List<MembershipPlanModel>> getCustomPlans();

  /// Suscribirse a un plan (sin pago, para FREE)
  Future<MembershipStatusModel> subscribe(String plan);

  /// Crear pago en MercadoPago para un plan
  Future<PaymentResultModel> createPayment(String plan);

  /// Suscribirse con tarjeta vía MercadoPago
  Future<PaymentResultModel> subscribeWithCard(
    String plan,
    String cardTokenId, {
    String? discountCode,
  });

  /// Actualizar/upgrade de plan
  Future<MembershipStatusModel> upgradePlan(String newPlan);

  /// Aplicar código de descuento
  Future<DiscountResultModel> applyDiscount(String code);

  /// Pausar suscripción
  Future<bool> pauseSubscription();

  /// Reanudar suscripción
  Future<bool> resumeSubscription();

  /// Cancelar suscripción
  Future<bool> cancelSubscription();

  /// Obtener historial de auditoría
  Future<List<Map<String, dynamic>>> getAuditHistory();
}
