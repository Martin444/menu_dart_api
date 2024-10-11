import 'dart:convert';

import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';
import 'package:menu_dart_api/by_feature/wardrobe/post_wardrobe/model/post_ward_params.dart';
import 'package:menu_dart_api/by_feature/wardrobe/put_wardrobe/data/repository/put_wardrobes_repository.dart';

import 'package:http/http.dart' as http;

class PutWardrobesProvider extends PutWardrobesRepository {
  @override
  Future<void> putEditWardrobes(PostWardParams params) async {
    try {
      Uri wardrobeCreateURl = Uri.parse('${API.defaulBaseUrl}/wardrobe/edit');
      var wardrobe = await http.put(
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

      if (wardrobe.statusCode != 201 || wardrobe.statusCode != 200) {
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
