import 'dart:convert';

import 'package:menu_dart_api/by_feature/user_roles/find_user/data/repository/find_user_repository.dart';
import 'package:menu_dart_api/by_feature/user_roles/find_user/model/find_user_response.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class FindUserProvider extends FindUserRepository {
  @override
  Future<FindUserResponse> findUserByEmail(String email) async {
    try {
      final uri = Uri.parse(
        '${API.defaulBaseUrl}/user-roles/find-user?email=${Uri.encodeQueryComponent(email)}',
      );
      final response = await API.httpClient.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
      );

      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorData['message'] ?? 'Usuario no encontrado',
        );
      }

      return FindUserResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
