import 'package:meta/meta.dart';

/// Model representing a ticket type for an event.
///
/// Ticket types define pricing, availability, and purchase limits
/// for different categories of tickets (e.g., General, VIP, Early Bird).
@immutable
class TicketTypeModel {
  /// Unique identifier for the ticket type.
  final String id;

  /// ID of the event this ticket type belongs to.
  final String eventId;

  /// Name of the ticket type (e.g., 'General Admission', 'VIP').
  final String name;

  /// Price per ticket.
  final double price;

  /// Total quantity available for sale.
  final int totalQuantity;

  /// Number of tickets already sold.
  final int soldQuantity;

  /// When ticket sales begin.
  final DateTime saleStartDate;

  /// When ticket sales end.
  final DateTime saleEndDate;

  /// Maximum number of tickets per user.
  final int maxPerUser;

  /// Current status (e.g., 'active', 'sold_out', 'inactive').
  final String status;

  /// When the ticket type was created.
  final DateTime createdAt;

  /// When the ticket type was last updated.
  final DateTime updatedAt;

  const TicketTypeModel({
    required this.id,
    required this.eventId,
    required this.name,
    required this.price,
    required this.totalQuantity,
    this.soldQuantity = 0,
    required this.saleStartDate,
    required this.saleEndDate,
    required this.maxPerUser,
    this.status = 'active',
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates a [TicketTypeModel] from a JSON map.
  ///
  /// Throws [FormatException] if required fields are missing.
  factory TicketTypeModel.fromJson(Map<String, dynamic> json) {
    final id = json['id']?.toString();
    String? eventId = json['eventId']?.toString();
    if (eventId == null || eventId.isEmpty) {
      final eventMap = json['event'];
      if (eventMap is Map<String, dynamic>) {
        eventId = eventMap['id']?.toString();
      }
    }
    final name = json['name']?.toString();
    final saleStartDateStr = json['saleStartDate']?.toString();
    final saleEndDateStr = json['saleEndDate']?.toString();
    final createdAtStr = json['createdAt']?.toString();
    final updatedAtStr = json['updatedAt']?.toString();

    if (id == null || id.isEmpty) {
      throw FormatException('TicketTypeModel: id is required', json);
    }
    if (eventId == null || eventId.isEmpty) {
      throw FormatException('TicketTypeModel: eventId is required', json);
    }
    if (name == null || name.isEmpty) {
      throw FormatException('TicketTypeModel: name is required', json);
    }

    final price = _parseDouble(json['price']) ?? 0.0;
    final totalQuantity = int.tryParse(json['totalQuantity']?.toString() ?? '') ?? 0;
    final soldQuantity = int.tryParse(json['soldQuantity']?.toString() ?? '') ?? 0;
    final maxPerUser = int.tryParse(json['maxPerUser']?.toString() ?? '') ?? 10;

    final saleStartDate = saleStartDateStr != null
        ? DateTime.tryParse(saleStartDateStr)
        : null;
    final saleEndDate = saleEndDateStr != null
        ? DateTime.tryParse(saleEndDateStr)
        : null;
    final createdAt = createdAtStr != null
        ? DateTime.tryParse(createdAtStr)
        : null;
    final updatedAt = updatedAtStr != null
        ? DateTime.tryParse(updatedAtStr)
        : null;

    if (saleStartDate == null) {
      throw FormatException('TicketTypeModel: saleStartDate is required', json);
    }
    if (saleEndDate == null) {
      throw FormatException('TicketTypeModel: saleEndDate is required', json);
    }
    if (createdAt == null) {
      throw FormatException('TicketTypeModel: createdAt is required', json);
    }
    if (updatedAt == null) {
      throw FormatException('TicketTypeModel: updatedAt is required', json);
    }

    return TicketTypeModel(
      id: id,
      eventId: eventId,
      name: name,
      price: price,
      totalQuantity: totalQuantity,
      soldQuantity: soldQuantity,
      saleStartDate: saleStartDate,
      saleEndDate: saleEndDate,
      maxPerUser: maxPerUser,
      status: json['status']?.toString() ?? 'active',
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

  /// Converts this ticket type to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventId': eventId,
      'name': name,
      'price': price,
      'totalQuantity': totalQuantity,
      'soldQuantity': soldQuantity,
      'saleStartDate': saleStartDate.toIso8601String(),
      'saleEndDate': saleEndDate.toIso8601String(),
      'maxPerUser': maxPerUser,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Creates a copy of this ticket type with the given fields replaced.
  TicketTypeModel copyWith({
    String? id,
    String? eventId,
    String? name,
    double? price,
    int? totalQuantity,
    int? soldQuantity,
    DateTime? saleStartDate,
    DateTime? saleEndDate,
    int? maxPerUser,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TicketTypeModel(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      name: name ?? this.name,
      price: price ?? this.price,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      soldQuantity: soldQuantity ?? this.soldQuantity,
      saleStartDate: saleStartDate ?? this.saleStartDate,
      saleEndDate: saleEndDate ?? this.saleEndDate,
      maxPerUser: maxPerUser ?? this.maxPerUser,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Number of tickets still available.
  int get remainingQuantity => totalQuantity - soldQuantity;

  /// Whether tickets are sold out.
  bool get isSoldOut => remainingQuantity <= 0;

  /// Whether ticket sales are currently active.
  bool get isOnSale {
    final now = DateTime.now();
    return now.isAfter(saleStartDate) &&
        now.isBefore(saleEndDate) &&
        !isSoldOut &&
        status == 'active';
  }

  /// Whether ticket sales haven't started yet.
  bool get isUpcoming => DateTime.now().isBefore(saleStartDate);

  /// Whether ticket sales have ended.
  bool get isSaleEnded => DateTime.now().isAfter(saleEndDate);

  /// Formatted price string.
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  /// Percentage of tickets sold (0.0 to 1.0).
  double get soldPercentage =>
      totalQuantity > 0 ? soldQuantity / totalQuantity : 0.0;

  @override
  String toString() {
    return 'TicketTypeModel(id: $id, name: $name, price: $price, remaining: $remainingQuantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TicketTypeModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
