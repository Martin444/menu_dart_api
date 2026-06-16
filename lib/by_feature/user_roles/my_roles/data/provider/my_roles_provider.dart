import 'dart:convert';

import 'package:menu_dart_api/by_feature/auth/models/user_role.dart';
import 'package:menu_dart_api/by_feature/user_roles/my_roles/data/repository/my_roles_repository.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class MyRolesProvider extends MyRolesRepository {
  @override
  Future<List<UserRole>> getMyRoles({String? context, String? resourceId}) async {
    try {
      final queryParams = <String, String>{};
      if (context != null) queryParams['context'] = context;
      if (resourceId != null) queryParams['resourceId'] = resourceId;

      final queryString = queryParams.isNotEmpty
          ? '?${queryParams.entries.map((e) => '${e.key}=${e.value}').join('&')}'
          : '';

      final Uri url = Uri.parse('${API.defaulBaseUrl}/user-roles/my-roles$queryString');
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
          errorData['message'] ?? 'Error al obtener mis roles',
        );
      }

      final responseData = jsonDecode(response.body);
      final List<dynamic> data = responseData['data'] is List
          ? responseData['data']
          : (responseData['data']?['data'] as List<dynamic>? ?? []);

      return data
          .map((e) => UserRole.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
