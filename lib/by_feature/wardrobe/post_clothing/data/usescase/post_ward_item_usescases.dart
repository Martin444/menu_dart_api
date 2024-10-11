import 'package:menu_dart_api/by_feature/wardrobe/post_clothing/data/provider/post_ward_item_provider.dart';
import 'package:menu_dart_api/by_feature/wardrobe/get_me_wardrobe/model/clothing_item_model.dart';

class PostWardItemUsesCases {
  PostWardItemUsesCases();

  Future<ClothingItemModel> execute(String menuId, ClothingItemModel item) async {
    try {
      var response = await PostWardItemProvider().postWardItemFromUser(
        menuId,
        item,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
