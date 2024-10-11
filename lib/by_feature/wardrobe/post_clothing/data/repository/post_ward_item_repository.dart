import 'package:menu_dart_api/by_feature/wardrobe/get_me_wardrobe/model/clothing_item_model.dart';

abstract class PostWardItemRepository {
  Future<ClothingItemModel> postWardItemFromUser(String menuId, ClothingItemModel item);
}
