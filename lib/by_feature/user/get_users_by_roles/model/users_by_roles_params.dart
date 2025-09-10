import 'package:menu_dart_api/by_feature/user/get_me_profile/model/roles_users.dart';

/// Parámetros para la consulta de usuarios por roles
///
/// Esta clase encapsula los parámetros necesarios para realizar
/// una consulta de usuarios filtrada por roles específicos.
class UsersByRolesParams {
  /// Lista de roles por los cuales filtrar usuarios
  final List<RolesUsers> roles;

  /// Indica si se deben incluir cuentas vinculadas en la respuesta
  final bool withVinculedAccount;

  /// Indica si se deben incluir menús en la respuesta
  final bool includeMenus;

  const UsersByRolesParams({
    required this.roles,
    this.withVinculedAccount = false,
    this.includeMenus = false,
  });

  /// Convierte los parámetros a un Map para el envío HTTP
  Map<String, dynamic> toJson() {
    return {
      'roles': roles.map((role) => role.toString().split('.').last).toList(),
      'withVinculedAccount': withVinculedAccount,
      'includeMenus': includeMenus,
    };
  }

  /// Crea una instancia desde un Map
  factory UsersByRolesParams.fromJson(Map<String, dynamic> json) {
    return UsersByRolesParams(
      roles: (json['roles'] as List<dynamic>)
          .map((roleString) => RolesFuncionts.getTypeRoleByRoleString(roleString))
          .where((role) => role != null)
          .cast<RolesUsers>()
          .toList(),
      withVinculedAccount: json['withVinculedAccount'] ?? false,
      includeMenus: json['includeMenus'] ?? false,
    );
  }

  @override
  String toString() {
    return 'UsersByRolesParams(roles: $roles, withVinculedAccount: $withVinculedAccount, includeMenus: $includeMenus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UsersByRolesParams &&
        other.roles.length == roles.length &&
        other.roles.every((role) => roles.contains(role)) &&
        other.withVinculedAccount == withVinculedAccount &&
        other.includeMenus == includeMenus;
  }

  @override
  int get hashCode {
    return roles.hashCode ^ withVinculedAccount.hashCode ^ includeMenus.hashCode;
  }
}
