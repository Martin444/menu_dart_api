import 'dart:convert';

import 'package:menu_dart_api/by_feature/user_roles/my_permissions/data/repository/my_permissions_repository.dart';
import 'package:menu_dart_api/by_feature/user_roles/models/user_permissions_response.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class MyPermissionsProvider extends MyPermissionsRepository {
  @override
  Future<UserPermissionsResponse> getMyPermissions(String context) async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}/user-roles/my-permissions/$context');
      final response = await API.httpClient.get(
        url,
        headers: {
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
      );

      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorData['message'] ?? 'Error al obtener mis permisos',
        );
      }

      return UserPermissionsResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
