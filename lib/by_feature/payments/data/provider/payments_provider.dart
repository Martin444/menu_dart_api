import 'dart:convert';

import 'package:menu_dart_api/by_feature/payments/data/repository/payments_repository.dart';
import 'package:menu_dart_api/by_feature/payments/models/payment_status_response.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class PaymentsProvider extends PaymentsRepository {
  @override
  Future<PaymentStatusResponse> getPaymentStatus(String paymentId) async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}/payments/status/$paymentId');
      final response = await API.httpClient.get(
        url,
        headers: {'Authorization': 'Bearer ${API.loginAccessToken}'},
      );

      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorData['message'] ?? 'Error al consultar estado de pago',
        );
      }

      final data = jsonDecode(response.body);
      return PaymentStatusResponse.fromJson(
        data is Map<String, dynamic> ? (data['data'] ?? data) : {},
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> checkinPayment(String paymentId) async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}/payments/checkin/$paymentId');
      final response = await API.httpClient.post(
        url,
        headers: {'Authorization': 'Bearer ${API.loginAccessToken}'},
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        final errorData = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorData['message'] ?? 'Error al verificar pago',
        );
      }

      final data = jsonDecode(response.body);
      return data is Map<String, dynamic> ? data : {};
    } catch (e) {
      rethrow;
    }
  }
}
