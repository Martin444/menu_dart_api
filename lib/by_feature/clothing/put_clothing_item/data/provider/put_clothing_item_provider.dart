import 'dart:convert';
import 'package:menu_dart_api/by_feature/clothing/put_clothing_item/data/repository/put_clothing_item_repository.dart';
import 'package:menu_dart_api/by_feature/wardrobe/get_me_wardrobe/model/clothing_item_model.dart';
import 'package:menu_dart_api/core/api.dart';

import 'package:http/http.dart' as http;
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class PutClothingItemProvider extends PutClothingItemRepository {
  @override
  Future editClothingItemFromUser(ClothingItemModel item) async {
    try {
      Uri loginURl = Uri.parse('${API.defaulBaseUrl}/wardrobe/edit-item');
      var login = await http.put(loginURl,
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${API.loginAccessToken}',
          },
          body: jsonEncode(
            {
              "idWard": item.id,
              "name": item.name,
              "brand": item.brand,
              "photoURL": item.photoURL,
              "sizes": item.sizes,
              "color": item.color ?? '-',
              "price": item.price,
              "quantity": item.quantity,
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
