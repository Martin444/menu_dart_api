import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:menu_dart_api/by_feature/menu/get_menu_bydinning/data/repository/get_menu_repository.dart';
import 'package:menu_dart_api/by_feature/menu/get_menu_bydinning/model/menu_response.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class GetMenuProvider extends GetMenuRespository {
  @override
  Future<MenuResponse> getmenuByDining(String idDining) async {
    Uri userURl = Uri.parse('${API.defaulBaseUrl}/menu/bydining/$idDining');
    try {
      var response = await http.get(
        userURl,
      );
      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode,
          response.body,
        );
      }
      var respJson = jsonDecode(response.body);

      var menuRespon = MenuResponse.fromJson(respJson);

      return menuRespon;
    } catch (e) {
      rethrow;
    }
  }
}
