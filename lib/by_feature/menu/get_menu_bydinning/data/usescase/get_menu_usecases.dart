import 'package:menu_dart_api/by_feature/menu/get_menu_bydinning/data/provider/get_menu_provider.dart';
import 'package:menu_dart_api/by_feature/menu/get_menu_bydinning/model/menu_response.dart';

class GetMenuUseCase {
  GetMenuUseCase();

  Future<MenuResponse> execute(String id) async {
    try {
      var response = await GetMenuProvider().getmenuByDining(id);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
