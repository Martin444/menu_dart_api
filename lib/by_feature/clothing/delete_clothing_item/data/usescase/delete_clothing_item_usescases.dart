import 'package:menu_dart_api/by_feature/clothing/delete_clothing_item/data/provider/delete_clothing_item_provider.dart';
import 'package:menu_dart_api/by_feature/wardrobe/get_me_wardrobe/model/clothing_item_model.dart';

class DeleteClothingItemUsesCases {
  DeleteClothingItemUsesCases();

  Future<dynamic> execute(ClothingItemModel item) async {
    try {
      var response = await DeleteClothingItemProvider().deleteMenuItemFromUser(
        item,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
