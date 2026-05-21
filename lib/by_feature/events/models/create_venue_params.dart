import 'package:menu_dart_api/by_feature/events/models/validatable_params.dart';

/// Parameters for creating a new venue.
class CreateVenueParams with ValidatableParams {
  /// Name of the venue (required, 2-100 characters).
  final String name;

  /// Physical address (optional).
  final String? address;

  /// Latitude coordinate (optional, -90 to 90).
  final double? latitude;

  /// Longitude coordinate (optional, -180 to 180).
  final double? longitude;

  /// Maximum capacity (optional, must be positive).
  final int? capacity;

  CreateVenueParams({
    required this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.capacity,
  });

  /// Validates all parameters.
  @override
  void validate() {
    validateStringLength(name, 'name', minLength: 2, maxLength: 100);

    if (latitude != null) {
      if (latitude! < -90 || latitude! > 90) {
        throw const ValidationException(
          'latitude must be between -90 and 90',
          field: 'latitude',
        );
      }
    }

    if (longitude != null) {
      if (longitude! < -180 || longitude! > 180) {
        throw const ValidationException(
          'longitude must be between -180 and 180',
          field: 'longitude',
        );
      }
    }

    if (capacity != null) {
      validatePositive(capacity, 'capacity');
    }

    // If one coordinate is provided, both must be provided
    if ((latitude != null && longitude == null) ||
        (latitude == null && longitude != null)) {
      throw const ValidationException(
        'Both latitude and longitude must be provided together',
      );
    }
  }

  /// Converts parameters to JSON.
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'name': name.trim(),
    };

    if (address != null && address!.isNotEmpty) {
      data['address'] = address!.trim();
    }

    if (latitude != null) data['latitude'] = latitude;
    if (longitude != null) data['longitude'] = longitude;
    if (capacity != null) data['capacity'] = capacity;

    return data;
  }

  @override
  String toString() {
    return 'CreateVenueParams(name: $name, address: $address, capacity: $capacity)';
  }
}
