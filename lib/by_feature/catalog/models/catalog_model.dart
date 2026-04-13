/// Modelo que representa un catálogo en el sistema
class CatalogModel {
  final String id;
  final String catalogType;
  final String? name;
  final String? description;
  final String ownerId;
  final String status;
  final String slug;
  final bool isPublic;
  final String? coverImageUrl;
  final int itemCount;
  final int capacity;
  final Map<String, dynamic>? metadata;
  final Map<String, dynamic>? settings;
  final List<String>? tags;
  final List<CatalogItemModel>? items;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? archivedAt;

  const CatalogModel({
    required this.id,
    required this.catalogType,
    this.name,
    this.description,
    required this.ownerId,
    required this.status,
    required this.slug,
    required this.isPublic,
    this.coverImageUrl,
    required this.itemCount,
    required this.capacity,
    this.metadata,
    this.settings,
    this.tags,
    this.items,
    required this.createdAt,
    required this.updatedAt,
    this.archivedAt,
  });

  factory CatalogModel.fromJson(Map<String, dynamic> json) {
    return CatalogModel(
      id: json['id'] as String? ?? '',
      catalogType: json['catalogType'] as String? ?? 'wardrobe',
      name: json['name'] as String?,
      description: json['description'] as String?,
      ownerId: json['ownerId'] as String? ?? '',
      status: json['status'] as String? ?? 'active',
      slug: json['slug'] as String? ?? '',
      isPublic: json['isPublic'] as bool? ?? true,
      coverImageUrl: json['coverImageUrl'] as String?,
      itemCount: json['itemCount'] as int? ?? 0,
      capacity: json['capacity'] as int? ?? 10,
      metadata: json['metadata'] as Map<String, dynamic>?,
      settings: json['settings'] as Map<String, dynamic>?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      items: json['items'] != null
          ? (json['items'] as List<dynamic>)
              .map((e) => CatalogItemModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
      archivedAt: json['archivedAt'] != null
          ? DateTime.parse(json['archivedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'catalogType': catalogType,
      'name': name,
      'description': description,
      'ownerId': ownerId,
      'status': status,
      'slug': slug,
      'isPublic': isPublic,
      'coverImageUrl': coverImageUrl,
      'itemCount': itemCount,
      'capacity': capacity,
      'metadata': metadata,
      'settings': settings,
      'tags': tags,
      'items': items?.map((e) => e.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'archivedAt': archivedAt?.toIso8601String(),
    };
  }
}

/// Modelo simplificado para items dentro de un catálogo
class CatalogItemModel {
  final String id;
  final String catalogId;
  final String name;
  final String? description;
  final String? photoURL;
  final double price;
  final double? discountPrice;
  final int quantity;
  final String? sku;
  final String status;
  final bool isAvailable;
  final bool isFeatured;
  final Map<String, dynamic>? attributes;
  final List<String>? additionalImages;
  final String? category;
  final List<String>? tags;
  final int displayOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CatalogItemModel({
    required this.id,
    required this.catalogId,
    required this.name,
    this.description,
    this.photoURL,
    required this.price,
    this.discountPrice,
    required this.quantity,
    this.sku,
    required this.status,
    required this.isAvailable,
    required this.isFeatured,
    this.attributes,
    this.additionalImages,
    this.category,
    this.tags,
    required this.displayOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CatalogItemModel.fromJson(Map<String, dynamic> json) {
    return CatalogItemModel(
      id: json['id'] as String,
      catalogId: json['catalogId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      photoURL: json['photoURL'] as String?,
      price: (json['price'] as num).toDouble(),
      discountPrice: json['discountPrice'] != null
          ? (json['discountPrice'] as num).toDouble()
          : null,
      quantity: json['quantity'] as int? ?? 0,
      sku: json['sku'] as String?,
      status: json['status'] as String? ?? 'available',
      isAvailable: json['isAvailable'] as bool? ?? true,
      isFeatured: json['isFeatured'] as bool? ?? false,
      attributes: json['attributes'] as Map<String, dynamic>?,
      additionalImages: (json['additionalImages'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      category: json['category'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      displayOrder: json['displayOrder'] as int? ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'catalogId': catalogId,
      'name': name,
      'description': description,
      'photoURL': photoURL,
      'price': price,
      'discountPrice': discountPrice,
      'quantity': quantity,
      'sku': sku,
      'status': status,
      'isAvailable': isAvailable,
      'isFeatured': isFeatured,
      'attributes': attributes,
      'additionalImages': additionalImages,
      'category': category,
      'tags': tags,
      'displayOrder': displayOrder,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
