/// Data model for ticket QR code information.
///
/// This model contains all the information needed to display
/// or share a ticket's QR code.
class TicketQrData {
  /// The unique ticket identifier.
  final String ticketId;

  /// The QR code content/string.
  final String qrCode;

  /// The event ID.
  final String eventId;

  /// The event name.
  final String eventName;

  /// The ticket type name.
  final String ticketTypeName;

  /// Customer name.
  final String customerName;

  /// Customer email.
  final String? customerEmail;

  /// Number of entries.
  final int quantity;

  /// Validation token for manual validation.
  final String? validationToken;

  /// When the ticket was purchased.
  final DateTime? purchasedAt;

  /// When the event starts.
  final DateTime? eventDate;

  /// Venue name.
  final String? venueName;

  /// URL to download the ticket PDF.
  final String? pdfUrl;

  const TicketQrData({
    required this.ticketId,
    required this.qrCode,
    required this.eventId,
    required this.eventName,
    required this.ticketTypeName,
    required this.customerName,
    this.customerEmail,
    this.quantity = 1,
    this.validationToken,
    this.purchasedAt,
    this.eventDate,
    this.venueName,
    this.pdfUrl,
  });

  /// Creates a [TicketQrData] from a JSON map.
  factory TicketQrData.fromJson(Map<String, dynamic> json) {
    return TicketQrData(
      ticketId: json['ticketId']?.toString() ??
          json['ticket_id']?.toString() ??
          '',
      qrCode: json['qrCode']?.toString() ??
          json['qr_code']?.toString() ??
          '',
      eventId: json['eventId']?.toString() ??
          json['event_id']?.toString() ??
          '',
      eventName: json['eventName']?.toString() ??
          json['event_name']?.toString() ??
          'Unknown Event',
      ticketTypeName: json['ticketTypeName']?.toString() ??
          json['ticket_type_name']?.toString() ??
          'General',
      customerName: json['customerName']?.toString() ??
          json['customer_name']?.toString() ??
          '',
      customerEmail: json['customerEmail']?.toString() ??
          json['customer_email']?.toString(),
      quantity: int.tryParse(json['quantity']?.toString() ?? '') ?? 1,
      validationToken: json['validationToken']?.toString() ??
          json['validation_token']?.toString(),
      purchasedAt: json['purchasedAt'] != null
          ? DateTime.tryParse(json['purchasedAt'].toString())
          : null,
      eventDate: json['eventDate'] != null
          ? DateTime.tryParse(json['eventDate'].toString())
          : null,
      venueName: json['venueName']?.toString() ??
          json['venue_name']?.toString(),
      pdfUrl: json['pdfUrl']?.toString() ??
          json['pdf_url']?.toString(),
    );
  }

  /// Converts this data to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'ticketId': ticketId,
      'qrCode': qrCode,
      'eventId': eventId,
      'eventName': eventName,
      'ticketTypeName': ticketTypeName,
      'customerName': customerName,
      if (customerEmail != null) 'customerEmail': customerEmail,
      'quantity': quantity,
      if (validationToken != null) 'validationToken': validationToken,
      if (purchasedAt != null) 'purchasedAt': purchasedAt!.toIso8601String(),
      if (eventDate != null) 'eventDate': eventDate!.toIso8601String(),
      if (venueName != null) 'venueName': venueName,
      if (pdfUrl != null) 'pdfUrl': pdfUrl,
    };
  }

  @override
  String toString() {
    return 'TicketQrData(ticketId: $ticketId, event: $eventName, '
        'customer: $customerName)';
  }
}
