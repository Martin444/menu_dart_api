import 'package:menu_dart_api/by_feature/menu/get_menu_bydinning/model/menu_model.dart';
import 'package:menu_dart_api/by_feature/menu/get_menu_bydinning/model/owner_model.dart';

class MenuResponse {
  OwnerModel? owner;
  List<MenuModel>? listmenus;

  // Constructor
  MenuResponse({this.owner, this.listmenus});

  // fromJson
  factory MenuResponse.fromJson(Map<String, dynamic> json) {
    return MenuResponse(
      owner: json['owner'] != null ? OwnerModel.fromJson(json['owner'] as Map<String, dynamic>) : null,
      listmenus: json['listmenu'] != null
          ? List<MenuModel>.from(json['listmenu'].map((item) => MenuModel.fromJson(item)))
          : null,
    );
  }
}
