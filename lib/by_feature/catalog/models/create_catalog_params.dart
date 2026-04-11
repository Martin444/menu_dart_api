import 'dart:typed_data';

/// Parámetros para crear un nuevo catálogo
class CreateCatalogParams {
  final String catalogType;
  final String? name;
  final String? description;
  final bool? isPublic;
  final Map<String, dynamic>? metadata;
  final Map<String, dynamic>? settings;
  final List<String>? tags;
  final Uint8List? coverImage;

  const CreateCatalogParams({
    required this.catalogType,
    this.name,
    this.description,
    this.isPublic,
    this.metadata,
    this.settings,
    this.tags,
    this.coverImage,
  });

  /// Convierte los parámetros a un Map para enviar en el form-data
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'catalogType': catalogType,
    };

    if (name != null) map['name'] = name;
    if (description != null) map['description'] = description;
    if (isPublic != null) map['isPublic'] = isPublic.toString();
    if (metadata != null) map['metadata'] = metadata;
    if (settings != null) map['settings'] = settings;
    if (tags != null && tags!.isNotEmpty) map['tags'] = tags!.join(',');

    return map;
  }
}
