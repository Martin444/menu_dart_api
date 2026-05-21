import 'package:meta/meta.dart';

/// Model representing a purchased ticket.
///
/// A ticket is created after successful payment and contains
/// all the information needed for event entry.
@immutable
class TicketModel {
  /// Unique identifier for the ticket.
  final String id;

  /// ID of the ticket type purchased.
  final String ticketTypeId;

  /// ID of the event.
  final String eventId;

  /// Name of the customer.
  final String customerName;

  /// Email of the customer.
  final String customerEmail;

  /// Number of entries/tickets purchased.
  final int quantity;

  /// Total amount paid.
  final double totalAmount;

  /// Current status (e.g., 'pending', 'paid', 'validated', 'cancelled').
  final String status;

  /// QR code for entry validation.
  final String? qrCode;

  /// Token for manual validation (optional).
  final String? validationToken;

  /// URL for payment (if pending).
  final String? paymentUrl;

  /// MercadoPago preference ID.
  final String? preferenceId;

  /// When the ticket was purchased.
  final DateTime? purchasedAt;

  /// When the ticket was created.
  final DateTime createdAt;

  /// When the ticket was last updated.
  final DateTime updatedAt;

  const TicketModel({
    required this.id,
    required this.ticketTypeId,
    required this.eventId,
    required this.customerName,
    required this.customerEmail,
    required this.quantity,
    required this.totalAmount,
    this.status = 'pending',
    this.qrCode,
    this.validationToken,
    this.paymentUrl,
    this.preferenceId,
    this.purchasedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates a [TicketModel] from a JSON map.
  ///
  /// Throws [FormatException] if required fields are missing.
  factory TicketModel.fromJson(Map<String, dynamic> json) {
    final id = json['id']?.toString();
    final ticketTypeId = json['ticketTypeId']?.toString();
    final eventId = json['eventId']?.toString();
    final customerName = json['customerName']?.toString();
    final customerEmail = json['customerEmail']?.toString();
    final createdAtStr = json['createdAt']?.toString();
    final updatedAtStr = json['updatedAt']?.toString();

    if (id == null || id.isEmpty) {
      throw FormatException('TicketModel: id is required', json);
    }
    if (ticketTypeId == null || ticketTypeId.isEmpty) {
      throw FormatException('TicketModel: ticketTypeId is required', json);
    }
    if (eventId == null || eventId.isEmpty) {
      throw FormatException('TicketModel: eventId is required', json);
    }
    if (customerName == null || customerName.isEmpty) {
      throw FormatException('TicketModel: customerName is required', json);
    }
    if (customerEmail == null || customerEmail.isEmpty) {
      throw FormatException('TicketModel: customerEmail is required', json);
    }

    final quantity = int.tryParse(json['quantity']?.toString() ?? '') ?? 1;
    final totalAmount = _parseDouble(json['totalAmount']) ?? 0.0;

    final createdAt = createdAtStr != null
        ? DateTime.tryParse(createdAtStr)
        : null;
    final updatedAt = updatedAtStr != null
        ? DateTime.tryParse(updatedAtStr)
        : null;
    final purchasedAt = json['purchasedAt'] != null
        ? DateTime.tryParse(json['purchasedAt'].toString())
        : null;

    if (createdAt == null) {
      throw FormatException('TicketModel: createdAt is required', json);
    }
    if (updatedAt == null) {
      throw FormatException('TicketModel: updatedAt is required', json);
    }

    return TicketModel(
      id: id,
      ticketTypeId: ticketTypeId,
      eventId: eventId,
      customerName: customerName,
      customerEmail: customerEmail,
      quantity: quantity,
      totalAmount: totalAmount,
      status: json['status']?.toString() ?? 'pending',
      qrCode: json['qrCode']?.toString(),
      validationToken: json['validationToken']?.toString(),
      paymentUrl: json['paymentUrl']?.toString(),
      preferenceId: json['preferenceId']?.toString(),
      purchasedAt: purchasedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Helper method to safely parse double values.
  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString());
  }

  /// Converts this ticket to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ticketTypeId': ticketTypeId,
      'eventId': eventId,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'quantity': quantity,
      'totalAmount': totalAmount,
      'status': status,
      if (qrCode != null) 'qrCode': qrCode,
      if (validationToken != null) 'validationToken': validationToken,
      if (paymentUrl != null) 'paymentUrl': paymentUrl,
      if (preferenceId != null) 'preferenceId': preferenceId,
      if (purchasedAt != null) 'purchasedAt': purchasedAt!.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Creates a copy of this ticket with the given fields replaced.
  TicketModel copyWith({
    String? id,
    String? ticketTypeId,
    String? eventId,
    String? customerName,
    String? customerEmail,
    int? quantity,
    double? totalAmount,
    String? status,
    String? qrCode,
    String? validationToken,
    String? paymentUrl,
    String? preferenceId,
    DateTime? purchasedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TicketModel(
      id: id ?? this.id,
      ticketTypeId: ticketTypeId ?? this.ticketTypeId,
      eventId: eventId ?? this.eventId,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      quantity: quantity ?? this.quantity,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      qrCode: qrCode ?? this.qrCode,
      validationToken: validationToken ?? this.validationToken,
      paymentUrl: paymentUrl ?? this.paymentUrl,
      preferenceId: preferenceId ?? this.preferenceId,
      purchasedAt: purchasedAt ?? this.purchasedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Whether the ticket payment is pending.
  bool get isPending => status == 'pending';

  /// Whether the ticket has been paid.
  bool get isPaid => status == 'paid';

  /// Whether the ticket has been validated/used.
  bool get isValidated => status == 'validated';

  /// Whether the ticket has been cancelled.
  bool get isCancelled => status == 'cancelled';

  /// Whether the ticket can be used for entry.
  bool get isUsable => isPaid && !isValidated && !isCancelled;

  /// Formatted price per ticket.
  double get pricePerTicket =>
      quantity > 0 ? totalAmount / quantity : totalAmount;

  /// Formatted total amount string.
  String get formattedTotal => '\$${totalAmount.toStringAsFixed(2)}';

  /// Customer initials for avatar display.
  String get customerInitials {
    final parts = customerName.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  @override
  String toString() {
    return 'TicketModel(id: $id, customer: $customerName, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TicketModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
