import 'dart:convert';

import 'package:menu_dart_api/by_feature/menu/post_menu/data/repository/post_menu_repository.dart';

import 'package:http/http.dart' as http;
import 'package:menu_dart_api/by_feature/menu/post_menu/model/menu_params.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class PostMenuProvider extends PostMenuRepository {
  @override
  Future<void> postNewMenu(MenuParams params) async {
    try {
      Uri wardrobeCreateURl = Uri.parse('${API.defaulBaseUrl}/menu/create');
      var wardrobe = await http.post(
        wardrobeCreateURl,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
        body: jsonEncode(
          {
            "description": params.description,
          },
        ),
      );

      if (wardrobe.statusCode != 201) {
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
