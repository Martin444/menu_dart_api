import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:menu_dart_api/by_feature/wardrobe/delete_wardrobe/data/repository/delete_wardrobes_repository.dart';
import 'package:menu_dart_api/by_feature/wardrobe/post_wardrobe/model/post_ward_params.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class DeleteWardrobesProvider extends DeleteWardrobesRepository {
  @override
  Future<void> deleteWardrobes(PostWardParams params) async {
    try {
      Uri wardrobeCreateURl = Uri.parse('${API.defaulBaseUrl}/wardrobe/delete');
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
