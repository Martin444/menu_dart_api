import 'dart:convert';

import 'package:menu_dart_api/by_feature/menu/get_menu_bydinning/model/menu_item_model.dart';
import 'package:menu_dart_api/by_feature/menu/put_menu_item/data/repository/put_menu_item_repository.dart';
import 'package:menu_dart_api/core/api.dart';

import 'package:http/http.dart' as http;
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class PutMenuItemProvider extends PutMenuItemRepository {
  @override
  Future putMenuItemFromUser(MenuItemModel item) async {
    try {
      Uri loginURl = Uri.parse('${API.defaulBaseUrl}/menu/edit-item');
      var login = await http.put(loginURl,
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${API.loginAccessToken}',
          },
          body: jsonEncode(
            {
              "idMenu": item.id,
              "name": item.name,
              "photoURL": item.photoUrl,
              "price": item.price,
              "ingredients": item.ingredients,
              "deliveryTime": item.deliveryTime,
            },
          ));
      if (login.statusCode != 201 && login.statusCode != 200) {
        throw ApiException(
          login.statusCode,
          login.body,
        );
      }
      return login;
    } catch (e) {
      rethrow;
    }
  }
}
