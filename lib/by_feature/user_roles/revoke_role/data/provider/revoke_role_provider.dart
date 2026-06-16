import 'dart:convert';

import 'package:menu_dart_api/by_feature/user_roles/revoke_role/data/repository/revoke_role_repository.dart';
import 'package:menu_dart_api/by_feature/user_roles/revoke_role/model/revoke_role_request.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class RevokeRoleProvider extends RevokeRoleRepository {
  @override
  Future<void> revokeRole(RevokeRoleRequest request) async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}/user-roles/revoke');
      final response = await API.httpClient.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorData['message'] ?? 'Error al revocar rol',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
