/// Status information for a ticket.
///
/// This model represents the current state of a ticket,
/// useful for pre-validation checks.
class TicketStatus {
  /// The ticket ID.
  final String ticketId;

  /// Whether the ticket is valid for entry.
  final bool isValid;

  /// Whether the ticket has already been used.
  final bool isUsed;

  /// Whether the ticket has expired.
  final bool isExpired;

  /// Current status string from the server.
  final String status;

  /// When the ticket was validated (if used).
  final DateTime? validatedAt;

  /// Who validated the ticket (if used).
  final String? validatedBy;

  /// The event ID.
  final String eventId;

  /// The event name.
  final String? eventName;

  /// The ticket type.
  final String? ticketTypeName;

  /// Customer information.
  final String? customerName;

  /// Number of entries allowed.
  final int quantity;

  /// Error or information message.
  final String? message;

  const TicketStatus({
    required this.ticketId,
    required this.isValid,
    this.isUsed = false,
    this.isExpired = false,
    this.status = 'unknown',
    this.validatedAt,
    this.validatedBy,
    required this.eventId,
    this.eventName,
    this.ticketTypeName,
    this.customerName,
    this.quantity = 1,
    this.message,
  });

  /// Creates a [TicketStatus] from a JSON map.
  factory TicketStatus.fromJson(Map<String, dynamic> json) {
    return TicketStatus(
      ticketId: json['ticketId']?.toString() ??
          json['ticket_id']?.toString() ??
          '',
      isValid: json['isValid'] ?? json['valid'] ?? false,
      isUsed: json['isUsed'] ?? json['used'] ?? false,
      isExpired: json['isExpired'] ?? json['expired'] ?? false,
      status: json['status']?.toString() ?? 'unknown',
      validatedAt: json['validatedAt'] != null
          ? DateTime.tryParse(json['validatedAt'].toString())
          : null,
      validatedBy: json['validatedBy']?.toString() ??
          json['validated_by']?.toString(),
      eventId: json['eventId']?.toString() ??
          json['event_id']?.toString() ??
          '',
      eventName: json['eventName']?.toString() ??
          json['event_name']?.toString(),
      ticketTypeName: json['ticketTypeName']?.toString() ??
          json['ticket_type_name']?.toString(),
      customerName: json['customerName']?.toString() ??
          json['customer_name']?.toString(),
      quantity: int.tryParse(json['quantity']?.toString() ?? '') ?? 1,
      message: json['message']?.toString() ??
          json['error']?.toString(),
    );
  }

  /// Converts this status to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'isValid': isValid,
      'isUsed': isUsed,
      'isExpired': isExpired,
      'status': status,
      if (validatedAt != null) 'validatedAt': validatedAt!.toIso8601String(),
      if (validatedBy != null) 'validatedBy': validatedBy,
      'eventId': eventId,
      if (eventName != null) 'eventName': eventName,
      if (ticketTypeName != null) 'ticketTypeName': ticketTypeName,
      if (customerName != null) 'customerName': customerName,
      'quantity': quantity,
      if (message != null) 'message': message,
    };
  }

  /// Whether the ticket can be used for entry.
  bool get canBeUsed => isValid && !isUsed && !isExpired;

  /// Creates a status for a valid, unused ticket.
  factory TicketStatus.valid({
    required String ticketId,
    required String eventId,
    String? eventName,
    String? ticketTypeName,
    String? customerName,
    int quantity = 1,
  }) {
    return TicketStatus(
      ticketId: ticketId,
      isValid: true,
      isUsed: false,
      isExpired: false,
      status: 'valid',
      eventId: eventId,
      eventName: eventName,
      ticketTypeName: ticketTypeName,
      customerName: customerName,
      quantity: quantity,
      message: 'Ticket is valid for entry',
    );
  }

  /// Creates a status for an already used ticket.
  factory TicketStatus.alreadyUsed({
    required String ticketId,
    required DateTime validatedAt,
    String? validatedBy,
  }) {
    return TicketStatus(
      ticketId: ticketId,
      isValid: false,
      isUsed: true,
      status: 'used',
      validatedAt: validatedAt,
      validatedBy: validatedBy,
      eventId: '',
      message: 'Ticket has already been used',
    );
  }

  @override
  String toString() {
    return 'TicketStatus(ticketId: $ticketId, status: $status, '
        'isValid: $isValid, isUsed: $isUsed)';
  }
}
