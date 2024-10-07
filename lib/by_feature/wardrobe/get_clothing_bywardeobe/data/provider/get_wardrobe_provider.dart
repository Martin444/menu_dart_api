import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:menu_dart_api/by_feature/wardrobe/get_clothing_bywardeobe/data/repository/get_clothing_repository.dart';
import 'package:menu_dart_api/by_feature/wardrobe/get_clothing_bywardeobe/model/wardrobe_response_params.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class GetClothingProvider extends GetClothingsRespository {
  @override
  Future<WardrobeResponseParams> getClothingByUserAcount(String idUser) async {
    Uri userURl = Uri.parse('${API.defaulBaseUrl}/wardrobe/bydining/$idUser');
    try {
      var response = await http.get(
        userURl,
      );
      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode,
          response.body,
        );
      }
      var respJson = jsonDecode(response.body);

      var wardResponse = WardrobeResponseParams.fromJson(respJson);

      return wardResponse;
    } catch (e) {
      rethrow;
    }
  }
}
