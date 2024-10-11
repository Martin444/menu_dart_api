import 'dart:convert';

import 'package:menu_dart_api/by_feature/menu/get_menu_bydinning/model/menu_item_model.dart';
import 'package:menu_dart_api/by_feature/menu/put_menu_item/data/repository/put_menu_item_repository.dart';
import 'package:menu_dart_api/core/api.dart';

import 'package:http/http.dart' as http;

class PutMenuItemProvider extends PutMenuItemRepository {
  @override
  Future putMenuItemFromUser(MenuItemModel item) async {
    try {
      Uri loginURl = Uri.parse('${API.defaulBaseUrl}/menu/edit');
      var login = await http.put(loginURl,
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${API.loginAccessToken}',
          },
          body: jsonEncode(
            {
              "id": item.id,
              "name": item.name,
              "photoURL": item.photoUrl,
              "price": item.price,
              "deliveryTime": item.deliveryTime
            },
          ));
      var respJson = jsonDecode(login.body);
      // if (respJson['id'] == null) {
      //   throw ApiException(
      //     respJson['statusCode'],
      //     respJson['message'],
      //   );
      // }
      return respJson;
    } catch (e) {
      rethrow;
    }
  }
}
