class MenuModel {
  String? id;
  String? name;
  String? description;
  String? imageUrl;
  String? userId;
  String? status;
  int? itemCount;
  List<MenuItemModel>? items;
  DateTime? createdAt;
  DateTime? updatedAt;

  MenuModel({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.userId,
    this.status,
    this.itemCount,
    this.items,
    this.createdAt,
    this.updatedAt,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      description: json['description']?.toString(),
      imageUrl: json['imageUrl']?.toString(),
      userId: json['userId']?.toString(),
      status: json['status']?.toString(),
      itemCount: int.tryParse(json['itemCount']?.toString() ?? ''),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => MenuItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'userId': userId,
      'status': status,
      'itemCount': itemCount,
      'items': items?.map((e) => e.toJson()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class MenuItemModel {
  String? id;
  String? name;
  String? description;
  double? price;
  String? imageUrl;
  String? photoUrl;
  String? menuId;
  int? deliveryTime;
  bool? isAvailable;
  List<String>? tags;
  List<String>? ingredients;
  DateTime? createdAt;
  DateTime? updatedAt;

  MenuItemModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
    this.photoUrl,
    this.menuId,
    this.deliveryTime,
    this.isAvailable,
    this.tags,
    this.ingredients,
    this.createdAt,
    this.updatedAt,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      description: json['description']?.toString(),
      price: double.tryParse(json['price']?.toString() ?? '0'),
      imageUrl: json['imageUrl']?.toString(),
      photoUrl: json['photoUrl']?.toString(),
      menuId: json['menuId']?.toString(),
      deliveryTime: int.tryParse(json['deliveryTime']?.toString() ?? ''),
      isAvailable: json['isAvailable'] is bool ? json['isAvailable'] as bool : (json['isAvailable']?.toString().toLowerCase() == 'true' ? true : (json['isAvailable'] == null ? null : false)),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'photoUrl': photoUrl,
      'menuId': menuId,
      'deliveryTime': deliveryTime,
      'isAvailable': isAvailable,
      'tags': tags,
      'ingredients': ingredients,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
