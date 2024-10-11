import 'dart:convert';

import 'package:menu_dart_api/by_feature/wardrobe/post_wardrobe/data/repository/post_wardrobes_repository.dart';
import 'package:menu_dart_api/by_feature/wardrobe/post_wardrobe/model/post_ward_params.dart';

import 'package:http/http.dart' as http;
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class PostWardrobesProvider extends PostWardrobesRepository {
  @override
  Future<void> postNewWardrobes(PostWardParams params) async {
    try {
      Uri wardrobeCreateURl = Uri.parse('${API.defaulBaseUrl}/wardrobe/create');
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
