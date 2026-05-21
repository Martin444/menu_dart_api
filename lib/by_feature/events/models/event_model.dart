import 'package:meta/meta.dart';

import 'ticket_type_model.dart';

/// Model representing an event in the system.
///
/// An event is a scheduled occurrence at a specific venue with
/// one or more ticket types available for purchase.
@immutable
class EventModel {
  /// Unique identifier for the event.
  final String id;

  /// Name of the event.
  final String name;

  /// Description of the event (optional).
  final String? description;

  /// Start date and time of the event.
  final DateTime startDate;

  /// End date and time of the event.
  final DateTime endDate;

  /// URL to the event image (optional).
  final String? imageUrl;

  /// ID of the venue where the event takes place.
  final String venueId;

  /// Complete venue object when included in response (optional).
  final Map<String, dynamic>? venue;

  /// Current status of the event (e.g., 'draft', 'published', 'cancelled').
  final String status;

  /// When the event was created.
  final DateTime createdAt;

  /// When the event was last updated.
  final DateTime updatedAt;

  /// Ticket types associated with this event.
  final List<TicketTypeModel> ticketTypes;

  const EventModel({
    required this.id,
    required this.name,
    this.description,
    required this.startDate,
    required this.endDate,
    this.imageUrl,
    required this.venueId,
    this.venue,
    this.status = 'draft',
    required this.createdAt,
    required this.updatedAt,
    this.ticketTypes = const [],
  });

  /// Creates an [EventModel] from a JSON map.
  ///
  /// Throws [FormatException] if required fields are missing or invalid.
  factory EventModel.fromJson(Map<String, dynamic> json) {
    // Validate required fields
    final id = json['id']?.toString();
    final name = json['name']?.toString();
    String? venueId = json['venueId']?.toString();
    if (venueId == null || venueId.isEmpty) {
      final venueMap = json['venue'];
      if (venueMap is Map<String, dynamic>) {
        venueId = venueMap['id']?.toString();
      }
    }
    final startDateStr = json['startDate']?.toString();
    final endDateStr = json['endDate']?.toString();
    final createdAtStr = json['createdAt']?.toString();
    final updatedAtStr = json['updatedAt']?.toString();

    if (id == null || id.isEmpty) {
      throw FormatException('EventModel: id is required', json);
    }
    if (name == null || name.isEmpty) {
      throw FormatException('EventModel: name is required', json);
    }
    if (venueId == null || venueId.isEmpty) {
      throw FormatException('EventModel: venueId is required', json);
    }

    final startDate = startDateStr != null
        ? DateTime.tryParse(startDateStr)
        : null;
    final endDate = endDateStr != null
        ? DateTime.tryParse(endDateStr)
        : null;
    final createdAt = createdAtStr != null
        ? DateTime.tryParse(createdAtStr)
        : null;
    final updatedAt = updatedAtStr != null
        ? DateTime.tryParse(updatedAtStr)
        : null;

    if (startDate == null) {
      throw FormatException('EventModel: startDate is required', json);
    }
    if (endDate == null) {
      throw FormatException('EventModel: endDate is required', json);
    }
    if (createdAt == null) {
      throw FormatException('EventModel: createdAt is required', json);
    }
    if (updatedAt == null) {
      throw FormatException('EventModel: updatedAt is required', json);
    }

    final ticketTypesJson = json['ticketTypes'];
    final List<TicketTypeModel> ticketTypes = ticketTypesJson is List
        ? ticketTypesJson
            .whereType<Map<String, dynamic>>()
            .map((e) {
              if (!e.containsKey('eventId') && !e.containsKey('event')) {
                e['eventId'] = id;
              }
              return TicketTypeModel.fromJson(e);
            })
            .toList()
        : const [];

    return EventModel(
      id: id,
      name: name,
      description: json['description']?.toString(),
      startDate: startDate,
      endDate: endDate,
      imageUrl: json['imageUrl']?.toString(),
      venueId: venueId,
      venue: json['venue'] is Map<String, dynamic>
          ? json['venue'] as Map<String, dynamic>
          : null,
      status: json['status']?.toString().toLowerCase() ?? 'draft',
      createdAt: createdAt,
      updatedAt: updatedAt,
      ticketTypes: ticketTypes,
    );
  }

  /// Converts this event to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      if (description != null) 'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      if (imageUrl != null) 'imageUrl': imageUrl,
      'venueId': venueId,
      if (venue != null) 'venue': venue,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'ticketTypes': ticketTypes.map((t) => t.toJson()).toList(),
    };
  }

  /// Creates a copy of this event with the given fields replaced.
  EventModel copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? imageUrl,
    String? venueId,
    Map<String, dynamic>? venue,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<TicketTypeModel>? ticketTypes,
  }) {
    return EventModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      imageUrl: imageUrl ?? this.imageUrl,
      venueId: venueId ?? this.venueId,
      venue: venue ?? this.venue,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      ticketTypes: ticketTypes ?? this.ticketTypes,
    );
  }

  /// Whether the event is in draft status.
  bool get isDraft => status == 'draft';

  /// Whether the event is published.
  bool get isPublished => status == 'published';

  /// Whether the event has been cancelled.
  bool get isCancelled => status == 'cancelled';

  /// Whether the event has already ended.
  bool get hasEnded => DateTime.now().isAfter(endDate);

  /// Whether the event is currently ongoing.
  bool get isOngoing {
    final now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }

  /// Whether the event is upcoming (hasn't started yet).
  bool get isUpcoming => DateTime.now().isBefore(startDate);

  @override
  String toString() {
    return 'EventModel(id: $id, name: $name, startDate: $startDate, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EventModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
