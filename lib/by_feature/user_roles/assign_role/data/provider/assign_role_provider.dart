import 'dart:convert';

import 'package:menu_dart_api/by_feature/user_roles/assign_role/data/repository/assign_role_repository.dart';
import 'package:menu_dart_api/by_feature/user_roles/assign_role/model/assign_role.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class AssignRoleProvider extends AssignRoleRepository {
  @override
  Future<AssignRoleResponse> assignRole(AssignRoleRequest request) async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}/user-roles/assign');
      final response = await API.httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode != 201) {
        final errorData = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorData['message'] ?? 'Error al asignar rol',
        );
      }

      return AssignRoleResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
