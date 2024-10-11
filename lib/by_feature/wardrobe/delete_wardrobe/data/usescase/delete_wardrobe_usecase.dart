import 'package:menu_dart_api/by_feature/wardrobe/delete_wardrobe/data/provider/delete_wardrobes_provider.dart';
import 'package:menu_dart_api/by_feature/wardrobe/post_wardrobe/model/post_ward_params.dart';

class DeleteWardrobeUsecase {
  static Future<dynamic> execute(PostWardParams params) {
    try {
      final responseWard = DeleteWardrobesProvider().deleteWardrobes(params);
      return responseWard;
    } catch (e) {
      rethrow;
    }
  }
}
