import 'package:menu_dart_api/by_feature/menu/get_menu_bydinning/model/menu_response.dart';

abstract class GetMenuRespository {
  Future<MenuResponse> getmenuByDining(String idDining);
}
