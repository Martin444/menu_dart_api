class CreateAppDataParams {
  final String key;
  final String value;
  final String? description;
  final bool isActive;

  const CreateAppDataParams({
    required this.key,
    required this.value,
    this.description,
    this.isActive = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
      'description': description,
      'isActive': isActive,
    };
  }

  @override
  String toString() {
    return 'CreateAppDataParams(key: $key, value: $value, description: $description, isActive: $isActive)';
  }
}
