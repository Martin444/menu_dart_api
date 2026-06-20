import 'dart:convert';

import 'package:menu_dart_api/by_feature/auth/models/user_role.dart';
import 'package:menu_dart_api/by_feature/user_roles/update_role/data/repository/update_role_repository.dart';
import 'package:menu_dart_api/by_feature/user_roles/update_role/model/update_role_request.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class UpdateRoleProvider extends UpdateRoleRepository {
  @override
  Future<UserRole> updateRole(String roleId, UpdateRoleRequest request) async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}/user-roles/$roleId');
      final response = await API.httpClient.patch(
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
          errorData['message'] ?? 'Error al actualizar rol',
        );
      }

      final responseData = jsonDecode(response.body);
      final outer = responseData['data'] as Map<String, dynamic>? ?? responseData;
      final data = outer['data'] as Map<String, dynamic>? ?? outer;
      return UserRole.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
