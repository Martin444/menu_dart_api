import 'dart:convert';

import 'package:menu_dart_api/by_feature/menu/get_menu_bydinning/model/menu_item_model.dart';
import 'package:menu_dart_api/by_feature/menu/post_menu_item/data/repository/post_menu_item_repository.dart';

import 'package:http/http.dart' as http;
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class PostMenuItemProvider extends PostMenuItemRepository {
  @override
  Future<MenuItemModel> postMenuItemFromUser(String menuId, MenuItemModel item) async {
    try {
      Uri newItemResponseURl = Uri.parse('${API.defaulBaseUrl}/menu/add-item');
      var newItemResponse = await http.post(
        newItemResponseURl,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
        body: jsonEncode(
          {
            "idMenu": menuId,
            "name": item.name,
            "photoURL": item.photoUrl,
            "price": item.price,
            "ingredients": item.ingredients,
            "deliveryTime": item.deliveryTime,
          },
        ),
      );
      if (newItemResponse.statusCode != 201) {
        throw ApiException(
          newItemResponse.statusCode,
          newItemResponse.body,
        );
      }
      var respJson = jsonDecode(newItemResponse.body);

      return MenuItemModel.fromJson(respJson);
    } catch (e) {
      rethrow;
    }
  }
}
