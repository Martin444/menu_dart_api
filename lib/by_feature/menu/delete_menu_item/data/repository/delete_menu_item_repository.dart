import 'package:menu_dart_api/by_feature/menu/get_menu_bydinning/model/menu_item_model.dart';

abstract class DeleteMenuItemRepository {
  Future<dynamic> deleteMenuItemFromUser(MenuItemModel item);
}
