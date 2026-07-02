import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:menu_dart_api/by_feature/membership/data/repository/membership_repository.dart';
import 'package:menu_dart_api/by_feature/membership/models/membership_status_model.dart';
import 'package:menu_dart_api/by_feature/membership/models/membership_plan_model.dart';
import 'package:menu_dart_api/by_feature/membership/models/discount_result_model.dart';
import 'package:menu_dart_api/by_feature/membership/models/payment_result_model.dart';
import 'package:menu_dart_api/by_feature/membership/models/payment_link_model.dart';
import 'package:menu_dart_api/by_feature/membership/models/billing_details_model.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

/// Provider que implementa las operaciones de membresía contra la API
class MembershipProvider extends MembershipRepository {
  dio.Dio get _dio => API.dioClient.dio;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${API.loginAccessToken}',
      };

  dynamic _parseResponse(dio.Response response) {
    return response.data is String
        ? jsonDecode(response.data)
        : response.data;
  }

  /// Extrae el contenido del campo 'data' del envelope estándar de la API:
  /// {statusCode, message, data: <inner>}
  /// Si no hay envelope, retorna el mapa original.
  Map<String, dynamic> _unwrapEnvelope(Map<String, dynamic> response) {
    if (response.containsKey('data') && response['data'] is Map) {
      return response['data'] as Map<String, dynamic>;
    }
    return response;
  }

  /// Extrae una lista de planes del envelope estándar de la API.
  /// Soporta: data.plans, data (si es List), plans directo.
  List<dynamic> _unwrapPlanList(dynamic response) {
    if (response is List) return response;
    if (response is! Map) return [];

    // {statusCode, message, data: {plans: [...]}}
    if (response.containsKey('data')) {
      final data = response['data'];
      if (data is List) return data;
      if (data is Map && data['plans'] is List) {
        return data['plans'] as List;
      }
    }

    // {plans: [...]}
    if (response.containsKey('plans') && response['plans'] is List) {
      return response['plans'] as List;
    }

    return [];
  }

  @override
  Future<MembershipStatusModel> getMembershipStatus() async {
    try {
      final response = await _dio.get(
        '${API.defaulBaseUrl}/membership/status',
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return MembershipStatusModel.fromJson(data);
    } catch (e) {
      if (e is dio.DioException) {
        // 404 = usuario sin membresía → FREE
        if (e.response?.statusCode == 404) {
          return MembershipStatusModel.free();
        }
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al obtener estado de membresía',
        );
      }
      rethrow;
    }
  }

  @override
  Future<List<MembershipPlanModel>> getAvailablePlans() async {
    try {
      final response = await _dio.get(
        '${API.defaulBaseUrl}/membership/plans',
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response);
      final plansList = _unwrapPlanList(parsed);

      return plansList
          .map((item) => MembershipPlanModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al obtener planes',
        );
      }
      rethrow;
    }
  }

  @override
  Future<List<MembershipPlanModel>> getCustomPlans() async {
    try {
      final response = await _dio.get(
        '${API.defaulBaseUrl}/membership/custom-plans',
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final plansList = _unwrapPlanList(parsed);
      if (plansList.isNotEmpty) {
        return plansList
            .map((item) => MembershipPlanModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al obtener planes personalizados',
        );
      }
      rethrow;
    }
  }

  @override
  Future<MembershipStatusModel> subscribe(String plan) async {
    try {
      final response = await _dio.post(
        '${API.defaulBaseUrl}/membership/subscribe',
        data: jsonEncode({'plan': plan}),
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return MembershipStatusModel.fromJson(data);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al suscribirse',
        );
      }
      rethrow;
    }
  }

  @override
  Future<PaymentResultModel> createPayment(String plan) async {
    try {
      final response = await _dio.post(
        '${API.defaulBaseUrl}/membership/create-payment',
        data: jsonEncode({'plan': plan}),
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return PaymentResultModel.fromJson(data);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al crear pago',
        );
      }
      rethrow;
    }
  }

  @override
  Future<PaymentResultModel> subscribeWithCard(
    String plan,
    String cardTokenId, {
    String? discountCode,
  }) async {
    try {
      final body = <String, dynamic>{
        'plan': plan,
        'cardTokenId': cardTokenId,
      };
      if (discountCode != null) body['discountCode'] = discountCode;

      final response = await _dio.post(
        '${API.defaulBaseUrl}/membership/subscribe-with-card',
        data: jsonEncode(body),
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return PaymentResultModel.fromJson(data);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al suscribirse con tarjeta',
        );
      }
      rethrow;
    }
  }

  @override
  Future<MembershipStatusModel> upgradePlan(String newPlan) async {
    try {
      final response = await _dio.put(
        '${API.defaulBaseUrl}/membership',
        data: jsonEncode({'plan': newPlan}),
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return MembershipStatusModel.fromJson(data);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al actualizar plan',
        );
      }
      rethrow;
    }
  }

  @override
  Future<DiscountResultModel> applyDiscount(String code) async {
    try {
      final response = await _dio.post(
        '${API.defaulBaseUrl}/membership/apply-discount',
        data: jsonEncode({'code': code}),
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return DiscountResultModel.fromJson(data);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al aplicar descuento',
        );
      }
      rethrow;
    }
  }

  @override
  Future<bool> pauseSubscription() async {
    try {
      final response = await _dio.post(
        '${API.defaulBaseUrl}/membership/subscription/pause',
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }
      return true;
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al pausar suscripción',
        );
      }
      rethrow;
    }
  }

  @override
  Future<bool> resumeSubscription() async {
    try {
      final response = await _dio.post(
        '${API.defaulBaseUrl}/membership/subscription/resume',
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }
      return true;
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al reanudar suscripción',
        );
      }
      rethrow;
    }
  }

  @override
  Future<bool> cancelSubscription() async {
    try {
      final response = await _dio.delete(
        '${API.defaulBaseUrl}/membership/subscription',
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }
      return true;
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al cancelar suscripción',
        );
      }
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAuditHistory() async {
    try {
      final response = await _dio.get(
        '${API.defaulBaseUrl}/membership/audit',
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final data = _parseResponse(response);
      if (data is List) {
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al obtener historial',
        );
      }
      rethrow;
    }
  }

  // --- Admin Methods ---

  @override
  Future<List<MembershipPlanModel>> getAllPlansAdmin() async {
    try {
      final response = await _dio.get(
        '${API.defaulBaseUrl}/admin/subscription-plans',
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response);
      final plansList = _unwrapPlanList(parsed);

      return plansList
          .map((item) => MembershipPlanModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al obtener todos los planes (admin)',
        );
      }
      rethrow;
    }
  }

  @override
  Future<MembershipPlanModel> getPlanByIdAdmin(String id) async {
    try {
      final response = await _dio.get(
        '${API.defaulBaseUrl}/admin/subscription-plans/$id',
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return MembershipPlanModel.fromJson(data);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al obtener plan por ID (admin)',
        );
      }
      rethrow;
    }
  }

  @override
  Future<MembershipPlanModel> createPlan(Map<String, dynamic> planData) async {
    try {
      final response = await _dio.post(
        '${API.defaulBaseUrl}/admin/subscription-plans',
        data: jsonEncode(planData),
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return MembershipPlanModel.fromJson(data);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al crear plan',
        );
      }
      rethrow;
    }
  }

  @override
  Future<MembershipPlanModel> updatePlan(String id, Map<String, dynamic> planData) async {
    try {
      final response = await _dio.put(
        '${API.defaulBaseUrl}/admin/subscription-plans/$id',
        data: jsonEncode(planData),
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return MembershipPlanModel.fromJson(data);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al actualizar plan',
        );
      }
      rethrow;
    }
  }

  @override
  Future<bool> archivePlan(String id) async {
    try {
      final response = await _dio.delete(
        '${API.defaulBaseUrl}/admin/subscription-plans/$id',
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }
      return true;
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al archivar plan',
        );
      }
      rethrow;
    }
  }

  @override
  Future<MembershipPlanModel> setDefaultPlan(String planId) async {
    try {
      final response = await _dio.put(
        '${API.defaulBaseUrl}/admin/subscription-plans/$planId',
        data: jsonEncode({'isDefault': true}),
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return MembershipPlanModel.fromJson(data);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al establecer plan predeterminado',
        );
      }
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getPlanStats() async {
    try {
      final response = await _dio.get(
        '${API.defaulBaseUrl}/admin/subscription-plans/stats',
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final data = _parseResponse(response);
      if (data is Map && data['data'] != null && data['data'] is Map) {
        return data['data'] as Map<String, dynamic>;
      }
      return data as Map<String, dynamic>;
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al obtener estadísticas de planes',
        );
      }
      rethrow;
    }
  }

  @override
  Future<bool> seedStandardPlans() async {
    try {
      final response = await _dio.post(
        '${API.defaulBaseUrl}/admin/subscription-plans/seed-standard-plans',
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }
      return true;
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al sembrar planes estándar',
        );
      }
      rethrow;
    }
  }

  @override
  Future<MembershipStatusModel> assignPlanToUser(String userId, String plan) async {
    try {
      final response = await _dio.post(
        '${API.defaulBaseUrl}/admin/memberships/user/$userId/assign/$plan',
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return MembershipStatusModel.fromJson(data);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al asignar plan al usuario',
        );
      }
      rethrow;
    }
  }

  // --- Admin Billing Methods ---

  @override
  Future<PaymentLinkModel> generatePaymentLink({
    required String userId,
    required String plan,
    required double amount,
    int periodMonths = 1,
    String? description,
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'plan': plan,
        'amount': amount,
        'periodMonths': periodMonths,
      };
      if (description != null) body['description'] = description;

      final response = await _dio.post(
        '${API.defaulBaseUrl}/admin/memberships/generate-payment-link',
        data: jsonEncode(body),
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return PaymentLinkModel.fromJson(data);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al generar link de pago',
        );
      }
      rethrow;
    }
  }

  @override
  Future<AutoBillingResponseModel> enableAutoBilling({
    required String userId,
    required String plan,
    required String cardTokenId,
    double? amount,
    String billingCycle = 'monthly',
  }) async {
    try {
      final body = <String, dynamic>{
        'userId': userId,
        'plan': plan,
        'cardTokenId': cardTokenId,
        'billingCycle': billingCycle,
      };
      if (amount != null) body['amount'] = amount;

      final response = await _dio.post(
        '${API.defaulBaseUrl}/admin/memberships/enable-auto-billing',
        data: jsonEncode(body),
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return AutoBillingResponseModel.fromJson(data);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al habilitar auto-billing',
        );
      }
      rethrow;
    }
  }

  @override
  Future<BillingDetailsModel> getBillingDetails(String membershipId) async {
    try {
      final response = await _dio.get(
        '${API.defaulBaseUrl}/admin/memberships/$membershipId/billing-details',
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return BillingDetailsModel.fromJson(data);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al obtener detalles de facturación',
        );
      }
      rethrow;
    }
  }

  @override
  Future<ChangeAmountResponseModel> changeBillingAmount({
    required String membershipId,
    required double newAmount,
    String? reason,
  }) async {
    try {
      final body = <String, dynamic>{
        'newAmount': newAmount,
      };
      if (reason != null) body['reason'] = reason;

      final response = await _dio.patch(
        '${API.defaulBaseUrl}/admin/memberships/$membershipId/billing-amount',
        data: jsonEncode(body),
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return ChangeAmountResponseModel.fromJson(data);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al cambiar monto de facturación',
        );
      }
      rethrow;
    }
  }

  @override
  Future<AutoBillingResponseModel> migrateToAutoBilling({
    required String membershipId,
    required String cardTokenId,
    double? amount,
  }) async {
    try {
      final body = <String, dynamic>{
        'cardTokenId': cardTokenId,
      };
      if (amount != null) body['amount'] = amount;

      final response = await _dio.post(
        '${API.defaulBaseUrl}/admin/memberships/$membershipId/migrate-to-auto-billing',
        data: jsonEncode(body),
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return AutoBillingResponseModel.fromJson(data);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al migrar a auto-billing',
        );
      }
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> migrateToManualBilling(String membershipId) async {
    try {
      final response = await _dio.post(
        '${API.defaulBaseUrl}/admin/memberships/$membershipId/migrate-to-manual',
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      return _parseResponse(response) as Map<String, dynamic>;
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al migrar a billing manual',
        );
      }
      rethrow;
    }
  }

  @override
  Future<bool> pauseUserSubscription(String membershipId) async {
    try {
      final response = await _dio.post(
        '${API.defaulBaseUrl}/admin/memberships/$membershipId/pause',
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }
      return true;
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al pausar suscripción',
        );
      }
      rethrow;
    }
  }

  @override
  Future<bool> resumeUserSubscription(String membershipId) async {
    try {
      final response = await _dio.post(
        '${API.defaulBaseUrl}/admin/memberships/$membershipId/resume',
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }
      return true;
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al reanudar suscripción',
        );
      }
      rethrow;
    }
  }

  @override
  Future<MembershipStatusModel> extendMembership({
    required String membershipId,
    required int periodMonths,
    String? reason,
  }) async {
    try {
      final body = <String, dynamic>{
        'periodMonths': periodMonths,
      };
      if (reason != null) body['reason'] = reason;

      final response = await _dio.post(
        '${API.defaulBaseUrl}/admin/memberships/$membershipId/extend',
        data: jsonEncode(body),
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return MembershipStatusModel.fromJson(data);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al extender membresía',
        );
      }
      rethrow;
    }
  }
}
