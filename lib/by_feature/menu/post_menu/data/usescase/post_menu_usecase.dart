import 'package:menu_dart_api/by_feature/menu/post_menu/data/provider/post_menu_provider.dart';
import 'package:menu_dart_api/by_feature/menu/post_menu/model/menu_params.dart';

class PostMenuUsecase {
  static Future<dynamic> execute(MenuParams params) {
    try {
      final responseWard = PostMenuProvider().postNewMenu(params);
      return responseWard;
    } catch (e) {
      rethrow;
    }
  }
}
