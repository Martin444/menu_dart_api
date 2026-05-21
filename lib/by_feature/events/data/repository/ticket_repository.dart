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

/// Repository interface for ticket operations.
///
/// This interface defines all ticket-related operations including
/// purchase, validation, and management.
abstract class TicketRepository {
  /// Purchases a ticket after payment confirmation.
  Future<TicketModel> purchase(PurchaseTicketParams params);

  /// Creates a MercadoPago checkout preference.
  Future<CheckoutResponse> checkout(CheckoutParams params);

  /// Downloads a ticket PDF.
  ///
  /// TODO: Consider changing return type to List<int> for binary data.
  Future<String> downloadPdf(String ticketId);

  /// Validates a ticket by its QR code.
  Future<TicketModel> validateQrCode(String code);

  /// Manually validates a ticket with validation token.
  Future<TicketModel> validateTicket(ValidateTicketParams params);

  /// Validates a ticket offline using pre-synchronized data.
  Future<OfflineValidationResult> validateOffline(ValidateOfflineParams params);

  /// Retrieves QR code data for a ticket.
  Future<TicketQrData> getQrData(String ticketId);

  /// Regenerates a ticket's QR code.
  Future<TicketModel> regenerateQr(String ticketId);

  /// Checks the current status of a ticket.
  Future<TicketStatus> checkStatus(CheckTicketParams params);
}
