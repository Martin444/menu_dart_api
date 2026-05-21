import 'package:menu_dart_api/by_feature/events/models/validatable_params.dart';

/// Parameters for creating a checkout preference.
class CheckoutParams with ValidatableParams {
  /// ID of the ticket type (required).
  final String ticketTypeId;

  /// Number of tickets (required, must be > 0).
  final int quantity;

  /// Customer name (required, 2-100 characters).
  final String customerName;

  /// Customer email (required, must be valid email).
  final String customerEmail;

  /// Tenant/organization ID (required).
  final String tenantId;

  CheckoutParams({
    required this.ticketTypeId,
    required this.quantity,
    required this.customerName,
    required this.customerEmail,
    required this.tenantId,
  });

  /// Validates all parameters.
  @override
  void validate() {
    validateRequiredString(ticketTypeId, 'ticketTypeId');
    validatePositive(quantity, 'quantity');
    validateStringLength(customerName, 'customerName', minLength: 2, maxLength: 100);
    validateEmail(customerEmail, 'customerEmail');
    validateRequiredString(tenantId, 'tenantId');
  }

  /// Converts parameters to JSON.
  Map<String, dynamic> toJson() {
    return {
      'ticketTypeId': ticketTypeId,
      'quantity': quantity,
      'customerName': customerName.trim(),
      'customerEmail': customerEmail.trim().toLowerCase(),
      'tenantId': tenantId,
    };
  }

  @override
  String toString() {
    return 'CheckoutParams(ticketTypeId: $ticketTypeId, quantity: $quantity, tenantId: $tenantId)';
  }
}
