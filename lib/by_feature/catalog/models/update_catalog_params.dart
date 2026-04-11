import 'dart:typed_data';

/// Parámetros para actualizar un catálogo existente
class UpdateCatalogParams {
  final String catalogId;
  final String? name;
  final String? description;
  final String? status;
  final String? slug;
  final bool? isPublic;
  final Map<String, dynamic>? metadata;
  final Map<String, dynamic>? settings;
  final List<String>? tags;
  final Uint8List? coverImage;

  const UpdateCatalogParams({
    required this.catalogId,
    this.name,
    this.description,
    this.status,
    this.slug,
    this.isPublic,
    this.metadata,
    this.settings,
    this.tags,
    this.coverImage,
  });

  /// Convierte los parámetros a un Map para enviar en el form-data
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    if (name != null) map['name'] = name;
    if (description != null) map['description'] = description;
    if (status != null) map['status'] = status;
    if (slug != null) map['slug'] = slug;
    if (isPublic != null) map['isPublic'] = isPublic.toString();
    if (metadata != null) map['metadata'] = metadata;
    if (settings != null) map['settings'] = settings;
    if (tags != null && tags!.isNotEmpty) map['tags'] = tags!.join(',');

    return map;
  }
}
