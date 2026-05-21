import 'package:meta/meta.dart';

/// Model representing a venue/location where events take place.
@immutable
class VenueModel {
  /// Unique identifier for the venue.
  final String id;

  /// Name of the venue.
  final String name;

  /// Physical address of the venue (optional).
  final String? address;

  /// Latitude coordinate for mapping (optional).
  final double? latitude;

  /// Longitude coordinate for mapping (optional).
  final double? longitude;

  /// Maximum capacity of the venue (optional).
  final int? capacity;

  /// When the venue was created.
  final DateTime createdAt;

  /// When the venue was last updated.
  final DateTime updatedAt;

  const VenueModel({
    required this.id,
    required this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.capacity,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates a [VenueModel] from a JSON map.
  ///
  /// Throws [FormatException] if required fields are missing.
  factory VenueModel.fromJson(Map<String, dynamic> json) {
    final id = json['id']?.toString();
    final name = json['name']?.toString();
    final createdAtStr = json['createdAt']?.toString();
    final updatedAtStr = json['updatedAt']?.toString();

    if (id == null || id.isEmpty) {
      throw FormatException('VenueModel: id is required', json);
    }
    if (name == null || name.isEmpty) {
      throw FormatException('VenueModel: name is required', json);
    }

    final createdAt = createdAtStr != null
        ? DateTime.tryParse(createdAtStr)
        : null;
    final updatedAt = updatedAtStr != null
        ? DateTime.tryParse(updatedAtStr)
        : null;

    if (createdAt == null) {
      throw FormatException('VenueModel: createdAt is required', json);
    }
    if (updatedAt == null) {
      throw FormatException('VenueModel: updatedAt is required', json);
    }

    return VenueModel(
      id: id,
      name: name,
      address: json['address']?.toString(),
      latitude: _parseDouble(json['latitude']),
      longitude: _parseDouble(json['longitude']),
      capacity: int.tryParse(json['capacity']?.toString() ?? ''),
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

  /// Converts this venue to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      if (address != null) 'address': address,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (capacity != null) 'capacity': capacity,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Creates a copy of this venue with the given fields replaced.
  VenueModel copyWith({
    String? id,
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    int? capacity,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VenueModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      capacity: capacity ?? this.capacity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Whether the venue has location coordinates.
  bool get hasLocation => latitude != null && longitude != null;

  /// Formatted display string for the location.
  String get locationDisplay {
    if (address != null && address!.isNotEmpty) return address!;
    if (hasLocation) return '$latitude, $longitude';
    return 'Location not specified';
  }

  @override
  String toString() {
    return 'VenueModel(id: $id, name: $name, capacity: $capacity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VenueModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
