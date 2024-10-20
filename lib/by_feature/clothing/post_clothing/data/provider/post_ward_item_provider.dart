import 'dart:convert';

import 'package:menu_dart_api/by_feature/wardrobe/get_me_wardrobe/model/clothing_item_model.dart';

import 'package:http/http.dart' as http;
import 'package:menu_dart_api/by_feature/clothing/post_clothing/data/repository/post_ward_item_repository.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class PostWardItemProvider extends PostWardItemRepository {
  @override
  Future<ClothingItemModel> postWardItemFromUser(String menuId, ClothingItemModel item) async {
    try {
      Uri newItemResponseURl = Uri.parse('${API.defaulBaseUrl}/wardrobe/add-item');
      var newItemResponse = await http.post(
        newItemResponseURl,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
        body: jsonEncode(
          {
            "idWard": menuId,
            "name": item.name,
            "brand": item.brand,
            "photoURL": item.photoURL,
            "sizes": item.sizes,
            "color": item.color,
            "price": item.price,
            "quantity": item.quantity,
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

      return ClothingItemModel.fromJson(respJson);
    } catch (e) {
      rethrow;
    }
  }
}
