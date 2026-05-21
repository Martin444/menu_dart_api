import 'package:menu_dart_api/by_feature/events/models/validatable_params.dart';

/// Parameters for purchasing a ticket.
class PurchaseTicketParams with ValidatableParams {
  /// ID of the ticket type to purchase (required).
  final String ticketTypeId;

  /// Number of tickets to purchase (required, must be > 0).
  final int quantity;

  /// Name of the customer (required, 2-100 characters).
  final String customerName;

  /// Email of the customer (required, must be valid email).
  final String customerEmail;

  PurchaseTicketParams({
    required this.ticketTypeId,
    required this.quantity,
    required this.customerName,
    required this.customerEmail,
  });

  /// Validates all parameters.
  @override
  void validate() {
    validateRequiredString(ticketTypeId, 'ticketTypeId');
    validatePositive(quantity, 'quantity');
    validateStringLength(customerName, 'customerName', minLength: 2, maxLength: 100);
    validateEmail(customerEmail, 'customerEmail');
  }

  /// Converts parameters to JSON.
  Map<String, dynamic> toJson() {
    return {
      'ticketTypeId': ticketTypeId,
      'quantity': quantity,
      'customerName': customerName.trim(),
      'customerEmail': customerEmail.trim().toLowerCase(),
    };
  }

  @override
  String toString() {
    return 'PurchaseTicketParams(ticketTypeId: $ticketTypeId, quantity: $quantity, customer: $customerName)';
  }
}
