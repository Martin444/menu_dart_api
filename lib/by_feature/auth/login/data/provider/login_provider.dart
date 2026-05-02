import 'dart:convert';

import 'package:menu_dart_api/by_feature/auth/login/data/repository/login_repository.dart';
import 'package:menu_dart_api/by_feature/auth/login/model/user_succes_model.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class LoginProvider extends LoginRepository {
  @override
  Future<UserSuccess> loginCommerce({
    required String email,
    required String password,
  }) async {
    try {
      Uri loginURl = Uri.parse('${API.defaulBaseUrl}/auth/login');
      // Usar el cliente HTTP con soporte para Anonymous ID
      var login = await API.httpClient.post(
        loginURl,
        body: {
          "email": email,
          "password": password,
        },
      );
      if (login.statusCode != 201) {
        var respJson = jsonDecode(login.body);
        throw ApiException(
          login.statusCode,
          respJson['message'],
        );
      }
      var respJson = jsonDecode(login.body);
      final token = respJson['access_token'] ?? respJson['accessToken'] ?? '';
      API.setAccessToken(token);
      return UserSuccess(
        accessToken: token,
        needToChangePassword: respJson['needToChangePassword'] ?? false,
      );
    } catch (e) {
      rethrow;
    }
  }
}
