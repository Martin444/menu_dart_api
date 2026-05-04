class ClothingItemModel {
  String? id;
  String? name;
  String? brand;
  List<String>? sizes;
  String? color;
  double? price;
  int? quantity;
  int? wardrobeId;
  String? photoURL;

  ClothingItemModel({
    this.id,
    this.name,
    this.brand,
    this.sizes,
    this.color,
    this.price,
    this.quantity,
    this.wardrobeId,
    this.photoURL,
  });

  factory ClothingItemModel.fromJson(Map<String, dynamic> json) {
    return ClothingItemModel(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      brand: json['brand']?.toString(),
      sizes: (json['sizes'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      color: json['color']?.toString(),
      price: double.tryParse(json['price']?.toString() ?? ''),
      quantity: int.tryParse(json['quantity']?.toString() ?? ''),
      wardrobeId: int.tryParse(json['wardrobeId']?.toString() ?? ''),
      photoURL: json['photoURL']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'sizes': sizes,
      'color': color,
      'price': price,
      'quantity': quantity,
      'wardrobeId': wardrobeId,
      'photoURL': photoURL,
    };
  }
}
