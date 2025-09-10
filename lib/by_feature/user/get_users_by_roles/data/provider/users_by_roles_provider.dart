import 'dart:convert';

import 'package:menu_dart_api/by_feature/user/get_users_by_roles/data/repository/users_by_roles_repository.dart';
import 'package:menu_dart_api/by_feature/user/get_users_by_roles/model/users_by_roles_params.dart';
import 'package:menu_dart_api/by_feature/user/get_users_by_roles/model/users_by_roles_response.dart';
import 'package:http/http.dart' as http;
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

/// Provider que implementa las operaciones de consulta de usuarios por roles
///
/// Maneja las comunicaciones HTTP con la API para obtener usuarios
/// filtrados por roles específicos.
class UsersByRolesProvider extends UsersByRolesRepository {
  @override
  Future<UsersByRolesResponse> getUsersByRoles(UsersByRolesParams params) async {
    try {
      // Construye la URL del endpoint
      Uri userByRolesUrl = Uri.parse('${API.defaulBaseUrl}/user/by-roles');

      // Prepara los headers de la request
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${API.loginAccessToken}',
      };

      // Prepara el body de la request
      final body = jsonEncode(params.toJson());

      // Realiza la request POST
      var response = await http.post(
        userByRolesUrl,
        headers: headers,
        body: body,
      );

      // Verifica el status code de la respuesta
      if (response.statusCode != 201) {
        throw ApiException(
          response.statusCode,
          response.body,
        );
      }

      // Decodifica la respuesta JSON
      var respJson = jsonDecode(response.body);

      // Convierte la respuesta al modelo correspondiente
      return UsersByRolesResponse.fromJson(respJson);
    } catch (e) {
      // Re-lanza cualquier excepción que ocurra
      rethrow;
    }
  }
}
