enum BusinessContext {
  restaurant('restaurant'),
  wardrobe('wardrobe'),
  marketplace('marketplace'),
  general('general'),
  events('events');

  final String value;
  const BusinessContext(this.value);

  static BusinessContext fromString(String value) {
    return BusinessContext.values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw ArgumentError('Invalid BusinessContext: $value'),
    );
  }
}
