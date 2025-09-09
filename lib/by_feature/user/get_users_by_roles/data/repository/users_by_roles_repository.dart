import 'package:menu_dart_api/by_feature/user/get_users_by_roles/model/users_by_roles_params.dart';
import 'package:menu_dart_api/by_feature/user/get_users_by_roles/model/users_by_roles_response.dart';

/// Repository abstracto para operaciones relacionadas con la consulta de usuarios por roles
///
/// Define el contrato para las implementaciones que manejan la obtención
/// de usuarios filtrados por roles específicos.
abstract class UsersByRolesRepository {
  /// Obtiene usuarios filtrados por los roles especificados
  ///
  /// [params] - Parámetros de la consulta que incluyen roles y configuraciones
  ///
  /// Retorna una [UsersByRolesResponse] con la lista de usuarios encontrados
  /// o lanza una excepción si ocurre un error.
  Future<UsersByRolesResponse> getUsersByRoles(UsersByRolesParams params);
}
