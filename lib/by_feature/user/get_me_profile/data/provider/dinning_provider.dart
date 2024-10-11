import 'dart:convert';

import 'package:menu_dart_api/by_feature/user/get_me_profile/data/repository/dinning_repository.dart';
import 'package:menu_dart_api/by_feature/user/get_me_profile/model/dinning_model.dart';
import 'package:http/http.dart' as http;
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class DinningProvider extends DinningRepository {
  @override
  Future<DinningModel> getMe() async {
    try {
      Uri userURl = Uri.parse('${API.defaulBaseUrl}/user/me');
      var response = await http.get(
        headers: {'Authorization': 'Bearer ${API.loginAccessToken}'},
        userURl,
      );
      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode,
          response.body,
        );
      }
      var respJson = jsonDecode(response.body);

      return DinningModel.fromJson(respJson);
    } catch (e) {
      rethrow;
    }
  }
}
