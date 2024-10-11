import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:menu_dart_api/by_feature/wardrobe/get_me_wardrobe/data/repository/get_wardrobes_repository.dart';
import 'package:menu_dart_api/by_feature/wardrobe/get_me_wardrobe/model/wardrobe_model.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class GetWardrobesProvider extends GetWardrobesRepository {
  @override
  Future<List<WardrobeModel>> getWardRobes() async {
    try {
      Uri wardrobeCreateURl = Uri.parse('${API.defaulBaseUrl}/wardrobe/me');
      List<WardrobeModel> wards = [];
      var wardrobe = await http.get(
        wardrobeCreateURl,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
      );

      if (wardrobe.statusCode != 200) {
        throw ApiException(
          wardrobe.statusCode,
          wardrobe.body,
        );
      }

      final resJson = jsonDecode(wardrobe.body);

      resJson.forEach((e) {
        wards.add(WardrobeModel.fromJson(e));
      });

      return wards;
    } catch (e) {
      rethrow;
    }
  }
}
