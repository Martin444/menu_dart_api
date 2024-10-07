import 'package:menu_dart_api/by_feature/wardrobe/get_clothing_bywardeobe/data/provider/get_wardrobe_provider.dart';
import 'package:menu_dart_api/by_feature/wardrobe/get_clothing_bywardeobe/model/wardrobe_response_params.dart';

class GetClothingUserUsescase {
  GetClothingUserUsescase();

  Future<WardrobeResponseParams> execute(String id) async {
    try {
      var response = await GetClothingProvider().getClothingByUserAcount(id);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
