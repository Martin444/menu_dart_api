import 'dart:convert';

import 'package:menu_dart_api/by_feature/user_roles/get_user_permissions/data/repository/get_user_permissions_repository.dart';
import 'package:menu_dart_api/by_feature/user_roles/models/user_permissions_response.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class GetUserPermissionsProvider extends GetUserPermissionsRepository {
  @override
  Future<UserPermissionsResponse> getUserPermissions(String userId, String context) async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}/user-roles/user/$userId/permissions/$context');
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
          errorData['message'] ?? 'Error al obtener permisos',
        );
      }

      return UserPermissionsResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
