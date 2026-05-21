import 'package:menu_dart_api/by_feature/events/models/validatable_params.dart';

/// Parameters for creating a new ticket type.
class CreateTicketTypeParams with ValidatableParams {
  /// ID of the event this ticket type belongs to (required).
  final String eventId;

  /// Name of the ticket type (required, 2-50 characters).
  final String name;

  /// Price per ticket (required, must be >= 0).
  final double price;

  /// Total quantity available (required, must be > 0).
  final int totalQuantity;

  /// When ticket sales begin (required).
  final DateTime saleStartDate;

  /// When ticket sales end (required, must be after saleStartDate).
  final DateTime saleEndDate;

  /// Maximum tickets per user (required, must be > 0).
  final int maxPerUser;

  CreateTicketTypeParams({
    required this.eventId,
    required this.name,
    required this.price,
    required this.totalQuantity,
    required this.saleStartDate,
    required this.saleEndDate,
    required this.maxPerUser,
  });

  /// Validates all parameters.
  @override
  void validate() {
    validateRequiredString(eventId, 'eventId');
    validateStringLength(name, 'name', minLength: 2, maxLength: 50);
    validateNonNegative(price.toInt(), 'price');
    validatePositive(totalQuantity, 'totalQuantity');
    validatePositive(maxPerUser, 'maxPerUser');
    validateDateRange(saleStartDate, saleEndDate, 'saleStartDate', 'saleEndDate');

    // Validate maxPerUser doesn't exceed totalQuantity
    if (maxPerUser > totalQuantity) {
      throw const ValidationException(
        'maxPerUser cannot be greater than totalQuantity',
        field: 'maxPerUser',
      );
    }
  }

  /// Converts parameters to JSON.
  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'name': name.trim(),
      'price': price,
      'totalQuantity': totalQuantity,
      'saleStartDate': saleStartDate.toUtc().toIso8601String(),
      'saleEndDate': saleEndDate.toUtc().toIso8601String(),
      'maxPerUser': maxPerUser,
    };
  }

  @override
  String toString() {
    return 'CreateTicketTypeParams(eventId: $eventId, name: $name, price: \$$price)';
  }
}
