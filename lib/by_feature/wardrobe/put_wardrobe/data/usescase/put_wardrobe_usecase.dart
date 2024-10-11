import 'package:menu_dart_api/by_feature/wardrobe/post_wardrobe/model/post_ward_params.dart';
import 'package:menu_dart_api/by_feature/wardrobe/put_wardrobe/data/provider/put_wardrobes_provider.dart';

class PutWardrobeUsecase {
  static Future<dynamic> execute(PostWardParams params) {
    try {
      final responseWard = PutWardrobesProvider().putEditWardrobes(params);
      return responseWard;
    } catch (e) {
      rethrow;
    }
  }
}
