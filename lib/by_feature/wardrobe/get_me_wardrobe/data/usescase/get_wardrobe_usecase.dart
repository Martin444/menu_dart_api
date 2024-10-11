import 'package:menu_dart_api/by_feature/wardrobe/get_me_wardrobe/data/provider/get_wardrobes_provider.dart';
import 'package:menu_dart_api/by_feature/wardrobe/get_me_wardrobe/model/wardrobe_model.dart';

class GetWardrobeUsecase {
  static Future<List<WardrobeModel>> execute() async {
    try {
      final response = await GetWardrobesProvider().getWardRobes();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
