import 'dart:typed_data';

/// Parámetros para crear un nuevo item en un catálogo
class CreateCatalogItemParams {
  final String catalogId;
  final String name;
  final String? description;
  final double price;
  final double? discountPrice;
  final int? quantity;
  final String? sku;
  final bool? isAvailable;
  final bool? isFeatured;
  final Map<String, dynamic>? attributes;
  final String? category;
  final List<String>? tags;
  final int? displayOrder;
  final Uint8List? photo;

  const CreateCatalogItemParams({
    required this.catalogId,
    required this.name,
    required this.price,
    this.description,
    this.discountPrice,
    this.quantity,
    this.sku,
    this.isAvailable,
    this.isFeatured,
    this.attributes,
    this.category,
    this.tags,
    this.displayOrder,
    this.photo,
  });

  /// Convierte los parámetros a un Map para enviar en el form-data
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'price': price.toString(),
    };

    if (description != null) map['description'] = description;
    if (discountPrice != null) map['discountPrice'] = discountPrice.toString();
    if (quantity != null) map['quantity'] = quantity.toString();
    if (sku != null) map['sku'] = sku;
    if (isAvailable != null) map['isAvailable'] = isAvailable.toString();
    if (isFeatured != null) map['isFeatured'] = isFeatured.toString();
    if (attributes != null) map['attributes'] = attributes;
    if (category != null) map['category'] = category;
    if (tags != null && tags!.isNotEmpty) map['tags'] = tags;
    if (displayOrder != null) map['displayOrder'] = displayOrder.toString();

    return map;
  }
}
