import 'dart:convert';

import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';
import 'package:menu_dart_api/by_feature/menu/post_menu/model/menu_params.dart';
import 'package:menu_dart_api/by_feature/menu/delete_menu/data/repository/delete_menu_repository.dart';

import 'package:http/http.dart' as http;

class DeleteMenuProvider extends DeleteMenuRepository {
  @override
  Future<void> deleteMenu(MenuParams params) async {
    try {
      Uri wardrobeCreateURl = Uri.parse('${API.defaulBaseUrl}/menu/delete');
      var wardrobe = await http.delete(
        wardrobeCreateURl,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
        body: jsonEncode(
          {
            "id": params.id,
            "description": params.description,
          },
        ),
      );

      if (wardrobe.statusCode != 201 && wardrobe.statusCode != 200) {
        throw ApiException(
          wardrobe.statusCode,
          wardrobe.body,
        );
      }

      var respJson = jsonDecode(wardrobe.body);
      return respJson;
    } catch (e) {
      rethrow;
    }
  }
}
