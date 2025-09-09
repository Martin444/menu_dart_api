import 'package:menu_dart_api/by_feature/user/get_users_by_roles/data/provider/users_by_roles_provider.dart';
import 'package:menu_dart_api/by_feature/user/get_users_by_roles/model/users_by_roles_params.dart';
import 'package:menu_dart_api/by_feature/user/get_users_by_roles/model/users_by_roles_response.dart';

/// Use case para obtener usuarios filtrados por roles específicos
///
/// Encapsula la lógica de negocio para la consulta de usuarios por roles,
/// proporcionando una interfaz simple y limpia para esta operación.
class GetUsersByRolesUseCase {
  final UsersByRolesProvider _provider;

  /// Constructor que permite inyección de dependencias
  GetUsersByRolesUseCase([UsersByRolesProvider? provider]) : _provider = provider ?? UsersByRolesProvider();

  /// Ejecuta la consulta de usuarios por roles
  ///
  /// [params] - Parámetros de la consulta que incluyen roles y configuraciones
  ///
  /// Retorna una [UsersByRolesResponse] con la lista de usuarios encontrados
  /// o lanza una excepción si ocurre un error durante la operación.
  ///
  /// Ejemplo de uso:
  /// ```dart
  /// final useCase = GetUsersByRolesUseCase();
  /// final params = UsersByRolesParams(
  ///   roles: [RolesUsers.dinning, RolesUsers.clothes],
  ///   withVinculedAccount: true,
  /// );
  ///
  /// try {
  ///   final response = await useCase.execute(params);
  ///   print('Usuarios encontrados: ${response.users.length}');
  /// } catch (e) {
  ///   print('Error al obtener usuarios: $e');
  /// }
  /// ```
  Future<UsersByRolesResponse> execute(UsersByRolesParams params) async {
    try {
      // Valida los parámetros antes de ejecutar
      _validateParams(params);

      // Ejecuta la consulta a través del provider
      var response = await _provider.getUsersByRoles(params);

      return response;
    } catch (e) {
      // Re-lanza cualquier excepción que ocurra
      rethrow;
    }
  }

  /// Valida que los parámetros sean correctos antes de ejecutar la consulta
  void _validateParams(UsersByRolesParams params) {
    if (params.roles.isEmpty) {
      throw ArgumentError('La lista de roles no puede estar vacía');
    }
  }
}
