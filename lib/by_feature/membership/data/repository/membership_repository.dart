import 'package:menu_dart_api/by_feature/membership/models/membership_status_model.dart';
import 'package:menu_dart_api/by_feature/membership/models/membership_plan_model.dart';
import 'package:menu_dart_api/by_feature/membership/models/discount_result_model.dart';
import 'package:menu_dart_api/by_feature/membership/models/payment_result_model.dart';
import 'package:menu_dart_api/by_feature/membership/models/payment_link_model.dart';
import 'package:menu_dart_api/by_feature/membership/models/billing_details_model.dart';

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

  // --- Admin Methods ---

  /// Obtiene todos los planes (incluyendo inactivos) - Solo Admin
  Future<List<MembershipPlanModel>> getAllPlansAdmin();

  /// Obtiene un plan por ID - Solo Admin
  Future<MembershipPlanModel> getPlanByIdAdmin(String id);

  /// Crea un nuevo plan - Solo Admin
  Future<MembershipPlanModel> createPlan(Map<String, dynamic> planData);

  /// Actualiza un plan existente - Solo Admin
  Future<MembershipPlanModel> updatePlan(String id, Map<String, dynamic> planData);

  /// Archiva un plan (soft delete) - Solo Admin
  Future<bool> archivePlan(String id);

  /// Establece un plan como predeterminado - Solo Admin
  /// Solo puede haber un plan predeterminado a la vez
  Future<MembershipPlanModel> setDefaultPlan(String planId);

  /// Obtiene estadísticas de planes y suscripciones - Solo Admin
  Future<Map<String, dynamic>> getPlanStats();

  /// Semilla de planes estándar - Solo Admin
  Future<bool> seedStandardPlans();

  /// Asigna un plan a un usuario - Solo Admin
  Future<MembershipStatusModel> assignPlanToUser(String userId, String plan);

  // --- Admin Billing Methods ---

  /// Genera un link de pago manual para un usuario - Solo Admin
  Future<PaymentLinkModel> generatePaymentLink({
    required String userId,
    required String plan,
    required double amount,
    int periodMonths = 1,
    String? description,
  });

  /// Habilita auto-billing (suscripción automática) - Solo Admin
  Future<AutoBillingResponseModel> enableAutoBilling({
    required String userId,
    required String plan,
    required String cardTokenId,
    double? amount,
    String billingCycle = 'monthly',
  });

  /// Obtiene detalles de facturación de una membresía - Solo Admin
  Future<BillingDetailsModel> getBillingDetails(String membershipId);

  /// Cambia el monto de facturación para auto-billing - Solo Admin
  Future<ChangeAmountResponseModel> changeBillingAmount({
    required String membershipId,
    required double newAmount,
    String? reason,
  });

  /// Migra de billing manual a auto-billing - Solo Admin
  Future<AutoBillingResponseModel> migrateToAutoBilling({
    required String membershipId,
    required String cardTokenId,
    double? amount,
  });

  /// Migra de auto-billing a billing manual - Solo Admin
  Future<Map<String, dynamic>> migrateToManualBilling(String membershipId);

  /// Pausa la suscripción de un usuario (auto-billing) - Solo Admin
  Future<bool> pauseUserSubscription(String membershipId);

  /// Reanuda la suscripción de un usuario (auto-billing) - Solo Admin
  Future<bool> resumeUserSubscription(String membershipId);

  /// Extiende la membresía sin pago - Solo Admin
  Future<MembershipStatusModel> extendMembership({
    required String membershipId,
    required int periodMonths,
    String? reason,
  });
}
