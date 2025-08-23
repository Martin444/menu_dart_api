class UpdateAppDataParams {
  final String? key;
  final String? value;
  final String? description;
  final bool? isActive;

  const UpdateAppDataParams({
    this.key,
    this.value,
    this.description,
    this.isActive,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (key != null) data['key'] = key;
    if (value != null) data['value'] = value;
    if (description != null) data['description'] = description;
    if (isActive != null) data['isActive'] = isActive;

    return data;
  }

  @override
  String toString() {
    return 'UpdateAppDataParams(key: $key, value: $value, description: $description, isActive: $isActive)';
  }
}
