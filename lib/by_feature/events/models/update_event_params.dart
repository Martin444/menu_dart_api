import 'package:menu_dart_api/by_feature/events/models/validatable_params.dart';

/// Parameters for updating an existing event.
///
/// [eventId] is required. All other fields are optional and only
/// provided fields will be updated.
class UpdateEventParams with ValidatableParams {
  /// ID of the event to update (required).
  final String eventId;

  /// New name for the event (optional, 3-100 characters).
  final String? name;

  /// New description (optional, max 1000 characters).
  final String? description;

  /// New start date (optional).
  final DateTime? startDate;

  /// New end date (optional, must be after startDate if both provided).
  final DateTime? endDate;

  /// New image URL (optional).
  final String? imageUrl;

  /// New venue ID (optional).
  final String? venueId;

  /// New status (optional, e.g., 'draft', 'published', 'cancelled').
  final String? status;

  UpdateEventParams({
    required this.eventId,
    this.name,
    this.description,
    this.startDate,
    this.endDate,
    this.imageUrl,
    this.venueId,
    this.status,
  });

  /// Validates all provided parameters.
  ///
  /// Only validates fields that are not null.
  /// Throws [ValidationException] if any validation fails.
  @override
  void validate() {
    validateRequiredString(eventId, 'eventId');

    if (name != null) {
      validateStringLength(name, 'name', minLength: 3, maxLength: 100);
    }

    if (description != null && description!.isNotEmpty) {
      validateStringLength(description, 'description', maxLength: 1000);
    }

    if (startDate != null && endDate != null) {
      validateDateRange(startDate, endDate, 'startDate', 'endDate');
    }

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      final uri = Uri.tryParse(imageUrl!);
      if (uri == null || !uri.isAbsolute) {
        throw const ValidationException(
          'imageUrl must be a valid URL',
          field: 'imageUrl',
        );
      }
    }

    if (venueId != null) {
      validateRequiredString(venueId, 'venueId');
    }

    if (status != null) {
      final validStatuses = ['draft', 'published', 'cancelled', 'completed'];
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
    if (description != null) data['description'] = description!.trim();
    if (startDate != null) data['startDate'] = startDate!.toIso8601String();
    if (endDate != null) data['endDate'] = endDate!.toIso8601String();
    if (imageUrl != null) data['imageUrl'] = imageUrl;
    if (venueId != null) data['venueId'] = venueId;
    if (status != null) data['status'] = status!.toUpperCase();

    return data;
  }

  @override
  String toString() {
    return 'UpdateEventParams(eventId: $eventId, name: $name, status: $status)';
  }
}
