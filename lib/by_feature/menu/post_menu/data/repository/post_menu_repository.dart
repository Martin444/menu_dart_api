import 'package:menu_dart_api/by_feature/menu/post_menu/model/menu_params.dart';

abstract class PostMenuRepository {
  Future<void> postNewMenu(MenuParams params);
}
