import 'package:menu_dart_api/by_feature/wardrobe/post_wardrobe/model/post_ward_params.dart';

abstract class PutWardrobesRepository {
  Future<void> putEditWardrobes(PostWardParams params);
}
