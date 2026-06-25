import 'dart:convert';

import 'package:menu_dart_api/by_feature/user/get_me_profile/data/repository/dinning_repository.dart';
import 'package:menu_dart_api/by_feature/user/get_me_profile/model/dinning_model.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class DinningProvider extends DinningRepository {
  @override
  Future<DinningModel> getMe() async {
    try {
      Uri userURl = Uri.parse('${API.defaulBaseUrl}/user/me');
      var response = await API.httpClient.get(
        userURl,
        headers: {'Authorization': 'Bearer ${API.loginAccessToken}'},
      );
      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode,
          response.body,
        );
      }
      var respJson = jsonDecode(response.body);
      var dataJson = respJson['data'] ?? respJson;

      return DinningModel.fromJson(dataJson);
    } catch (e) {
      rethrow;
    }
  }
}
