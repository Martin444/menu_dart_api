import 'package:menu_dart_api/by_feature/events/models/validatable_params.dart';

/// Parameters for updating an existing ticket type.
class UpdateTicketTypeParams with ValidatableParams {
  /// ID of the ticket type to update (required).
  final String ticketTypeId;

  /// New name (optional, 2-50 characters).
  final String? name;

  /// New price (optional, must be >= 0).
  final double? price;

  /// New total quantity (optional, must be > sold quantity).
  final int? totalQuantity;

  /// New sale start date (optional).
  final DateTime? saleStartDate;

  /// New sale end date (optional, must be after saleStartDate).
  final DateTime? saleEndDate;

  /// New maximum per user (optional, must be > 0).
  final int? maxPerUser;

  /// New status (optional, e.g., 'active', 'inactive', 'sold_out').
  final String? status;

  UpdateTicketTypeParams({
    required this.ticketTypeId,
    this.name,
    this.price,
    this.totalQuantity,
    this.saleStartDate,
    this.saleEndDate,
    this.maxPerUser,
    this.status,
  });

  /// Validates all provided parameters.
  @override
  void validate() {
    validateRequiredString(ticketTypeId, 'ticketTypeId');

    if (name != null) {
      validateStringLength(name, 'name', minLength: 2, maxLength: 50);
    }

    if (price != null) {
      validateNonNegative(price!.toInt(), 'price');
    }

    if (totalQuantity != null) {
      validatePositive(totalQuantity, 'totalQuantity');
    }

    if (saleStartDate != null && saleEndDate != null) {
      validateDateRange(
        saleStartDate,
        saleEndDate,
        'saleStartDate',
        'saleEndDate',
      );
    }

    if (maxPerUser != null) {
      validatePositive(maxPerUser, 'maxPerUser');
    }

    if (status != null) {
      final validStatuses = ['active', 'inactive', 'sold_out', 'cancelled'];
      if (!validStatuses.contains(status)) {
        throw ValidationException(
          'status must be one of: ${validStatuses.join(", ")}',
          field: 'status',
        );
      }
    }
  }

  /// Converts parameters to JSON (only includes non-null values).
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (name != null) data['name'] = name!.trim();
    if (price != null) data['price'] = price;
    if (totalQuantity != null) data['totalQuantity'] = totalQuantity;
    if (saleStartDate != null) {
      data['saleStartDate'] = saleStartDate!.toIso8601String();
    }
    if (saleEndDate != null) {
      data['saleEndDate'] = saleEndDate!.toIso8601String();
    }
    if (maxPerUser != null) data['maxPerUser'] = maxPerUser;
    if (status != null) data['status'] = status;

    return data;
  }

  @override
  String toString() {
    return 'UpdateTicketTypeParams(ticketTypeId: $ticketTypeId, name: $name, price: $price)';
  }
}
