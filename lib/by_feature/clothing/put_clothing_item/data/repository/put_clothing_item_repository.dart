import 'package:menu_dart_api/by_feature/wardrobe/get_me_wardrobe/model/clothing_item_model.dart';

abstract class PutClothingItemRepository {
  Future<dynamic> editClothingItemFromUser(ClothingItemModel item);
}
