import 'package:menu_dart_api/by_feature/wardrobe/get_me_wardrobe/model/wardrobe_model.dart';

abstract class GetWardrobesRepository {
  Future<List<WardrobeModel>> getWardRobes();
}
