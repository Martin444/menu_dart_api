import 'package:menu_dart_api/by_feature/wardrobe/get_me_wardrobe/model/clothing_item_model.dart';

class WardrobeModel {
  final String? id;
  final String? idOwner;
  final String? description;
  final int? capacity;
  final List<ClothingItemModel>? items;

  WardrobeModel({
    required this.id,
    required this.idOwner,
    this.description,
    this.capacity,
    required this.items,
  });

  factory WardrobeModel.fromJson(Map<String, dynamic> json) {
    return WardrobeModel(
      id: json['id']?.toString(),
      idOwner: json['idOwner']?.toString(),
      description: json['description']?.toString(),
      capacity: int.tryParse(json['capacity']?.toString() ?? ''),
      items: (json['items'] as List<dynamic>?)?.map((itemJson) => ClothingItemModel.fromJson(itemJson)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idOwner': idOwner,
      'description': description,
      'capacity': capacity,
      'items': items?.map((item) => item.toJson()).toList(),
    };
  }
}
