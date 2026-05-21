/// Result model for offline ticket validation.
///
/// This model represents the result of validating a ticket without
/// internet connection, using pre-synchronized data.
class OfflineValidationResult {
  /// Whether the ticket is valid.
  final bool isValid;

  /// Whether the ticket has already been used.
  final bool isAlreadyUsed;

  /// The ticket ID if validation was successful.
  final String? ticketId;

  /// The event ID associated with the ticket.
  final String? eventId;

  /// The ticket type name.
  final String? ticketTypeName;

  /// Customer name.
  final String? customerName;

  /// Number of tickets/entries.
  final int? quantity;

  /// When the ticket was previously validated (if already used).
  final DateTime? validatedAt;

  /// Error message if validation failed.
  final String? errorMessage;

  /// The offline token used for validation.
  final String? offlineToken;

  const OfflineValidationResult({
    required this.isValid,
    this.isAlreadyUsed = false,
    this.ticketId,
    this.eventId,
    this.ticketTypeName,
    this.customerName,
    this.quantity,
    this.validatedAt,
    this.errorMessage,
    this.offlineToken,
  });

  /// Creates an [OfflineValidationResult] from a JSON map.
  factory OfflineValidationResult.fromJson(Map<String, dynamic> json) {
    return OfflineValidationResult(
      isValid: json['isValid'] ?? json['valid'] ?? false,
      isAlreadyUsed: json['isAlreadyUsed'] ?? json['already_used'] ?? false,
      ticketId: json['ticketId']?.toString() ?? json['ticket_id']?.toString(),
      eventId: json['eventId']?.toString() ?? json['event_id']?.toString(),
      ticketTypeName: json['ticketTypeName']?.toString() ??
          json['ticket_type_name']?.toString(),
      customerName: json['customerName']?.toString() ??
          json['customer_name']?.toString(),
      quantity: int.tryParse(json['quantity']?.toString() ?? ''),
      validatedAt: json['validatedAt'] != null
          ? DateTime.tryParse(json['validatedAt'].toString())
          : null,
      errorMessage: json['errorMessage']?.toString() ??
          json['error']?.toString(),
      offlineToken: json['offlineToken']?.toString() ??
          json['offline_token']?.toString(),
    );
  }

  /// Converts this result to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'isValid': isValid,
      'isAlreadyUsed': isAlreadyUsed,
      if (ticketId != null) 'ticketId': ticketId,
      if (eventId != null) 'eventId': eventId,
      if (ticketTypeName != null) 'ticketTypeName': ticketTypeName,
      if (customerName != null) 'customerName': customerName,
      if (quantity != null) 'quantity': quantity,
      if (validatedAt != null) 'validatedAt': validatedAt!.toIso8601String(),
      if (errorMessage != null) 'errorMessage': errorMessage,
      if (offlineToken != null) 'offlineToken': offlineToken,
    };
  }

  /// Creates a successful validation result.
  factory OfflineValidationResult.success({
    required String ticketId,
    required String eventId,
    String? ticketTypeName,
    String? customerName,
    int? quantity,
    String? offlineToken,
  }) {
    return OfflineValidationResult(
      isValid: true,
      isAlreadyUsed: false,
      ticketId: ticketId,
      eventId: eventId,
      ticketTypeName: ticketTypeName,
      customerName: customerName,
      quantity: quantity,
      offlineToken: offlineToken,
    );
  }

  /// Creates a failed validation result.
  factory OfflineValidationResult.failure(String errorMessage) {
    return OfflineValidationResult(
      isValid: false,
      errorMessage: errorMessage,
    );
  }

  @override
  String toString() {
    return 'OfflineValidationResult(isValid: $isValid, '
        'ticketId: $ticketId, errorMessage: $errorMessage)';
  }
}
