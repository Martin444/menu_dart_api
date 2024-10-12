import 'package:menu_dart_api/by_feature/menu/get_menu_bydinning/model/menu_item_model.dart';

import '../provider/delete_menu_item_provider.dart';

class DeleteMenuItemUsesCases {
  DeleteMenuItemUsesCases();

  Future<dynamic> execute(MenuItemModel item) async {
    try {
      var response = await DeleteMenuItemProvider().deleteMenuItemFromUser(
        item,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
