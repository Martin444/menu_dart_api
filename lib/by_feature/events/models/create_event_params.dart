import 'dart:typed_data';

import 'package:menu_dart_api/by_feature/events/models/validatable_params.dart';

/// Parameters for creating a new event.
///
/// All parameters are required except [description] and [image].
class CreateEventParams with ValidatableParams {
  /// Name of the event (required, 3-100 characters).
  final String name;

  /// Description of the event (optional, max 1000 characters).
  final String? description;

  /// Start date and time of the event (required, must be in the future).
  final DateTime startDate;

  /// End date and time of the event (required, must be after startDate).
  final DateTime endDate;

  /// Event banner image bytes (optional).
  final Uint8List? image;

  /// ID of the venue where the event takes place (required).
  final String venueId;

  CreateEventParams({
    required this.name,
    this.description,
    required this.startDate,
    required this.endDate,
    this.image,
    required this.venueId,
  });

  /// Validates all parameters.
  ///
  /// Throws [ValidationException] if any validation fails.
  @override
  void validate() {
    // Validate name
    validateStringLength(name, 'name', minLength: 3, maxLength: 100);

    // Validate description length if provided
    if (description != null && description!.isNotEmpty) {
      validateStringLength(description, 'description', maxLength: 1000);
    }

    // Validate venueId
    validateRequiredString(venueId, 'venueId');

    // Validate date range
    validateDateRange(startDate, endDate, 'startDate', 'endDate');

    // Validate startDate is in the future (with 1 minute buffer)
    final now = DateTime.now().subtract(const Duration(minutes: 1));
    if (startDate.isBefore(now)) {
      throw const ValidationException(
        'startDate must be in the future',
        field: 'startDate',
      );
    }
  }

  /// Converts parameters to JSON (for multipart text fields).
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'name': name.trim(),
      'startDate': startDate.toUtc().toIso8601String(),
      'endDate': endDate.toUtc().toIso8601String(),
      'venueId': venueId,
    };

    if (description != null && description!.isNotEmpty) {
      data['description'] = description!.trim();
    }

    return data;
  }

  @override
  String toString() {
    return 'CreateEventParams(name: $name, startDate: $startDate, venueId: $venueId)';
  }
}
