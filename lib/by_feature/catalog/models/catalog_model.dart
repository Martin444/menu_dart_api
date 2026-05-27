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
    // Extraer ownerId de forma segura (sea string o objeto anidado)
    String extractedOwnerId = '';
    if (json['ownerId'] != null) {
      if (json['ownerId'] is String) {
        extractedOwnerId = json['ownerId'] as String;
      } else if (json['ownerId'] is Map && json['ownerId']['id'] != null) {
        extractedOwnerId = json['ownerId']['id'].toString();
      }
    } else if (json['owner'] != null && json['owner'] is Map && json['owner']['id'] != null) {
      extractedOwnerId = json['owner']['id'].toString();
    }

    return CatalogModel(
      id: json['id']?.toString() ?? '',
      // Soporta tanto 'catalogType' como 'type' del JSON
      catalogType: json['catalogType']?.toString() ?? json['type']?.toString() ?? 'wardrobe',
      name: json['name']?.toString(),
      description: json['description']?.toString(),
      ownerId: extractedOwnerId,
      status: json['status']?.toString() ?? 'active',
      slug: json['slug']?.toString() ?? '',
      isPublic: _parseBool(json['isPublic']) ?? true,
      coverImageUrl: json['coverImageUrl']?.toString(),
      itemCount: _parseInt(json['itemCount']) ?? 0,
      capacity: _parseInt(json['capacity']) ?? 10,
      metadata: json['metadata'] is Map<String, dynamic> ? json['metadata'] as Map<String, dynamic> : null,
      settings: json['settings'] is Map<String, dynamic> ? json['settings'] as Map<String, dynamic> : null,
      tags: json['tags'] is List ? (json['tags'] as List).map((e) => e.toString()).toList() : null,
      items: json['items'] != null && json['items'] is List
          ? (json['items'] as List<dynamic>)
              .map((e) => CatalogItemModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      createdAt: _parseDate(json['createdAt']),
      updatedAt: _parseDate(json['updatedAt']),
      archivedAt: json['archivedAt'] != null ? _parseDate(json['archivedAt']) : null,
    );
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    if (value is Map && value.containsKey('value')) return _parseInt(value['value']);
    return null; // Si es un mapa vacío u otro objeto, retorna null para usar el default
  }

  static bool? _parseBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == 'true';
    if (value is Map && value.containsKey('value')) return _parseBool(value['value']);
    return null;
  }

  static DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    if (value is Map && value.containsKey('value')) return _parseDate(value['value']);
    return DateTime.now();
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
      id: json['id']?.toString() ?? '',
      catalogId: json['catalogId']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Sin nombre',
      description: json['description']?.toString(),
      photoURL: json['photoURL']?.toString(),
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      discountPrice: json['discountPrice'] != null
          ? double.tryParse(json['discountPrice'].toString())
          : null,
      quantity: CatalogModel._parseInt(json['quantity']) ?? 0,
      sku: json['sku']?.toString(),
      status: json['status']?.toString() ?? 'available',
      isAvailable: CatalogModel._parseBool(json['isAvailable']) ?? true,
      isFeatured: CatalogModel._parseBool(json['isFeatured']) ?? false,
      attributes: json['attributes'] is Map<String, dynamic> ? json['attributes'] as Map<String, dynamic> : null,
      additionalImages: json['additionalImages'] is List 
          ? (json['additionalImages'] as List).map((e) => e.toString()).toList()
          : null,
      category: json['category']?.toString(),
      tags: json['tags'] is List ? (json['tags'] as List).map((e) => e.toString()).toList() : null,
      displayOrder: CatalogModel._parseInt(json['displayOrder']) ?? 0,
      createdAt: CatalogModel._parseDate(json['createdAt']),
      updatedAt: CatalogModel._parseDate(json['updatedAt']),
    );
  }

  List<String> get ingredientsList {
    if (attributes == null) return [];
    final raw = attributes!['ingredients'];
    if (raw is List) return raw.map((e) => e.toString()).toList();
    if (raw is String && raw.isNotEmpty) return raw.split(',').map((e) => e.trim()).toList();
    return [];
  }

  bool get hasDiscount => discountPrice != null && discountPrice! < price;

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
