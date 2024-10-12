import 'dart:convert';

import 'package:menu_dart_api/by_feature/auth/login/data/repository/login_repository.dart';
import 'package:menu_dart_api/by_feature/auth/login/model/user_succes_model.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class LoginProvider extends LoginRepository {
  @override
  Future<UserSuccess> loginCommerce({
    required String email,
    required String password,
  }) async {
    try {
      Uri loginURl = Uri.parse('${API.defaulBaseUrl}/auth/login');
      var login = await http.post(
        loginURl,
        body: {
          "email": email,
          "password": password,
        },
      );
      var respJson = jsonDecode(login.body);
      if (respJson['access_token'] == null) {
        throw ApiException(
          respJson['statusCode'],
          respJson['message'],
        );
      }
      API.setAccessToken(respJson['access_token']);
      return UserSuccess(
        accessToken: respJson['access_token'],
        needToChangePassword: respJson['needToChangePassword'],
      );
    } catch (e) {
      rethrow;
    }
  }
}
