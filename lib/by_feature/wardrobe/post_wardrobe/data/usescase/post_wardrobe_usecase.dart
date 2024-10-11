import 'package:menu_dart_api/by_feature/wardrobe/post_wardrobe/model/post_ward_params.dart';
import 'package:menu_dart_api/by_feature/wardrobe/post_wardrobe/data/provider/post_wardrobes_provider.dart';

class PostWardrobeUsecase {
  static Future<dynamic> execute(PostWardParams params) {
    try {
      final responseWard = PostWardrobesProvider().postNewWardrobes(params);
      return responseWard;
    } catch (e) {
      rethrow;
    }
  }
}
