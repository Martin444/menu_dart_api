import 'package:menu_dart_api/by_feature/wardrobe/get_clothing_bywardeobe/model/wardrobe_model.dart';

class WardrobeResponseParams {
  String? owner;
  List<WardrobeModel>? listClothing;

  // Constructor
  WardrobeResponseParams({this.owner, this.listClothing});

  // fromJson
  factory WardrobeResponseParams.fromJson(Map<String, dynamic> json) {
    return WardrobeResponseParams(
      owner: json['owner'],
      listClothing: json['listmenu'] != null
          ? List<WardrobeModel>.from(json['listmenu'].map((item) => WardrobeModel.fromJson(item)))
          : null,
    );
  }
}
