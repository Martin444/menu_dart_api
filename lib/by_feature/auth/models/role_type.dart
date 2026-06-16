enum RoleType {
  customer('customer'),
  owner('owner'),
  admin('admin'),
  operator('operator'),
  manager('manager'),
  eventOrganizer('event_organizer');

  final String value;
  const RoleType(this.value);

  static RoleType fromString(String value) {
    return RoleType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw ArgumentError('Invalid RoleType: $value'),
    );
  }
}
