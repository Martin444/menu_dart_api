import 'package:menu_dart_api/by_feature/menu/post_menu/model/menu_params.dart';
import 'package:menu_dart_api/by_feature/menu/delete_menu/data/provider/delete_menu_provider.dart';

class DeleteMenuUsecase {
  static Future<dynamic> execute(MenuParams params) {
    try {
      final responseWard = DeleteMenuProvider().deleteMenu(params);
      return responseWard;
    } catch (e) {
      rethrow;
    }
  }
}
