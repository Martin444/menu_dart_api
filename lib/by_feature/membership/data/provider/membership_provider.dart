import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:menu_dart_api/by_feature/membership/data/repository/membership_repository.dart';
import 'package:menu_dart_api/by_feature/membership/models/membership_status_model.dart';
import 'package:menu_dart_api/by_feature/membership/models/membership_plan_model.dart';
import 'package:menu_dart_api/by_feature/membership/models/discount_result_model.dart';
import 'package:menu_dart_api/by_feature/membership/models/payment_result_model.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

/// Provider que implementa las operaciones de membresía contra la API
class MembershipProvider extends MembershipRepository {
  final dio.Dio _dio = dio.Dio();

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${API.loginAccessToken}',
      };

  dynamic _parseResponse(dio.Response response) {
    return response.data is String
        ? jsonDecode(response.data)
        : response.data;
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

      final data = _parseResponse(response) as Map<String, dynamic>;
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

      final data = _parseResponse(response) as Map<String, dynamic>;
      if (data['plans'] != null) {
        return (data['plans'] as List)
            .map((item) => MembershipPlanModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return [];
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

      final data = _parseResponse(response) as Map<String, dynamic>;
      if (data['plans'] != null) {
        return (data['plans'] as List)
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

      final data = _parseResponse(response) as Map<String, dynamic>;
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

      final data = _parseResponse(response) as Map<String, dynamic>;
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

      final data = _parseResponse(response) as Map<String, dynamic>;
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

      final data = _parseResponse(response) as Map<String, dynamic>;
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

      final data = _parseResponse(response) as Map<String, dynamic>;
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
}
