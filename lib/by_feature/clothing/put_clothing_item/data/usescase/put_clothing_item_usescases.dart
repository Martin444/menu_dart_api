import 'package:menu_dart_api/by_feature/clothing/put_clothing_item/data/provider/put_clothing_item_provider.dart';
import 'package:menu_dart_api/by_feature/wardrobe/get_me_wardrobe/model/clothing_item_model.dart';

class PutClothingItemUsesCases {
  PutClothingItemUsesCases();

  Future<dynamic> execute(ClothingItemModel item) async {
    try {
      var response = await PutClothingItemProvider().editClothingItemFromUser(
        item,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
