import 'dart:typed_data';

/// Parámetros para actualizar un item existente en un catálogo
class UpdateCatalogItemParams {
  final String catalogId;
  final String itemId;
  final String? name;
  final String? description;
  final String? photoURL;
  final double? price;
  final double? discountPrice;
  final int? quantity;
  final String? sku;
  final String? status;
  final bool? isAvailable;
  final bool? isFeatured;
  final Map<String, dynamic>? attributes;
  final List<String>? additionalImages;
  final String? category;
  final List<String>? tags;
  final int? displayOrder;
  final Uint8List? photo;

  const UpdateCatalogItemParams({
    required this.catalogId,
    required this.itemId,
    this.name,
    this.description,
    this.photoURL,
    this.price,
    this.discountPrice,
    this.quantity,
    this.sku,
    this.status,
    this.isAvailable,
    this.isFeatured,
    this.attributes,
    this.additionalImages,
    this.category,
    this.tags,
    this.displayOrder,
    this.photo,
  });

  /// Convierte los parámetros a un Map para enviar en el form-data
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    if (name != null) map['name'] = name;
    if (description != null) map['description'] = description;
    if (photoURL != null) map['photoURL'] = photoURL;
    if (price != null) map['price'] = price.toString();
    if (discountPrice != null) map['discountPrice'] = discountPrice.toString();
    if (quantity != null) map['quantity'] = quantity.toString();
    if (sku != null) map['sku'] = sku;
    if (status != null) map['status'] = status;
    if (isAvailable != null) map['isAvailable'] = isAvailable.toString();
    if (isFeatured != null) map['isFeatured'] = isFeatured.toString();
    if (attributes != null) map['attributes'] = attributes;
    if (additionalImages != null) map['additionalImages'] = additionalImages;
    if (category != null) map['category'] = category;
    if (tags != null && tags!.isNotEmpty) map['tags'] = tags;
    if (displayOrder != null) map['displayOrder'] = displayOrder.toString();

    return map;
  }
}
