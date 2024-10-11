import 'package:menu_dart_api/by_feature/menu/post_menu/model/menu_params.dart';
import 'package:menu_dart_api/by_feature/menu/put_menu/data/provider/put_menu_provider.dart';

class PutMenuUsecase {
  static Future<dynamic> execute(MenuParams params) {
    try {
      final responseWard = PutMenuProvider().putEditMenu(params);
      return responseWard;
    } catch (e) {
      rethrow;
    }
  }
}
