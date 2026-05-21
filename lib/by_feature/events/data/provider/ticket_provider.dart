import 'dart:convert';

import 'package:menu_dart_api/by_feature/events/data/repository/ticket_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/ticket_model.dart';
import 'package:menu_dart_api/by_feature/events/models/purchase_ticket_params.dart';
import 'package:menu_dart_api/by_feature/events/models/checkout_params.dart';
import 'package:menu_dart_api/by_feature/events/models/checkout_response.dart';
import 'package:menu_dart_api/by_feature/events/models/validate_ticket_params.dart';
import 'package:menu_dart_api/by_feature/events/models/validate_offline_params.dart';
import 'package:menu_dart_api/by_feature/events/models/offline_validation_result.dart';
import 'package:menu_dart_api/by_feature/events/models/check_ticket_params.dart';
import 'package:menu_dart_api/by_feature/events/models/ticket_status.dart';
import 'package:menu_dart_api/by_feature/events/models/ticket_qr_data.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

/// HTTP implementation of [TicketRepository].
///
/// This provider handles all HTTP communication for ticket operations,
/// including purchases, validations, and management.
class TicketProvider extends TicketRepository {
  /// Purchases a ticket after successful payment.
  @override
  Future<TicketModel> purchase(PurchaseTicketParams params) async {
    try {
      final url = Uri.parse('${API.defaulBaseUrl}/tickets/purchase');
      final response = await API.httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(params.toJson()),
      );
      if (response.statusCode != 201 && response.statusCode != 200) {
        throw ApiException(response.statusCode, response.body);
      }
      return TicketModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }

  /// Creates a MercadoPago checkout preference.
  @override
  Future<CheckoutResponse> checkout(CheckoutParams params) async {
    try {
      final url = Uri.parse('${API.defaulBaseUrl}/tickets/checkout');
      final response = await API.httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(params.toJson()),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(response.statusCode, response.body);
      }
      return CheckoutResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }

  /// Downloads a ticket PDF.
  ///
  /// TODO: Change return type to List<int> for proper binary handling.
  @override
  Future<String> downloadPdf(String ticketId) async {
    try {
      final url = Uri.parse('${API.defaulBaseUrl}/tickets/$ticketId/pdf');
      final response = await API.httpClient.get(url);
      if (response.statusCode != 200) {
        throw ApiException(response.statusCode, response.body);
      }
      return response.body;
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }

  /// Validates a ticket by scanning its QR code.
  @override
  Future<TicketModel> validateQrCode(String code) async {
    try {
      final url = Uri.parse('${API.defaulBaseUrl}/tickets/validate/$code');
      final response = await API.httpClient.post(
        url,
        headers: {
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
      );
      if (response.statusCode != 200) {
        throw ApiException(response.statusCode, response.body);
      }
      return TicketModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }

  /// Manually validates a ticket using validation token.
  @override
  Future<TicketModel> validateTicket(ValidateTicketParams params) async {
    try {
      final url = Uri.parse('${API.defaulBaseUrl}/tickets/validate');
      final response = await API.httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
        body: jsonEncode(params.toJson()),
      );
      if (response.statusCode != 200) {
        throw ApiException(response.statusCode, response.body);
      }
      return TicketModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }

  /// Validates a ticket offline using cached data.
  @override
  Future<OfflineValidationResult> validateOffline(
      ValidateOfflineParams params) async {
    try {
      final url = Uri.parse('${API.defaulBaseUrl}/tickets/validate-offline');
      final response = await API.httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(params.toJson()),
      );
      if (response.statusCode != 200) {
        throw ApiException(response.statusCode, response.body);
      }
      return OfflineValidationResult.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }

  /// Retrieves QR code data for a ticket.
  @override
  Future<TicketQrData> getQrData(String ticketId) async {
    try {
      final url = Uri.parse('${API.defaulBaseUrl}/tickets/$ticketId/qr-data');
      final response = await API.httpClient.get(
        url,
        headers: {
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
      );
      if (response.statusCode != 200) {
        throw ApiException(response.statusCode, response.body);
      }
      return TicketQrData.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }

  /// Regenerates a ticket's QR code.
  @override
  Future<TicketModel> regenerateQr(String ticketId) async {
    try {
      final url =
          Uri.parse('${API.defaulBaseUrl}/tickets/$ticketId/regenerate-qr');
      final response = await API.httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
        body: jsonEncode({}),
      );
      if (response.statusCode != 200) {
        throw ApiException(response.statusCode, response.body);
      }
      return TicketModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }

  /// Checks the current status of a ticket.
  @override
  Future<TicketStatus> checkStatus(CheckTicketParams params) async {
    try {
      final url = Uri.parse('${API.defaulBaseUrl}/tickets/check');
      final response = await API.httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
        body: jsonEncode(params.toJson()),
      );
      if (response.statusCode != 200) {
        throw ApiException(response.statusCode, response.body);
      }
      return TicketStatus.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }
}
