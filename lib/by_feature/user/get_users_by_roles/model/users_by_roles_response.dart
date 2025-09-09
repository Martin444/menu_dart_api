import 'package:menu_dart_api/by_feature/user/get_users_by_roles/model/user_by_role_model.dart';

/// Modelo que representa la respuesta de la API para la consulta de usuarios por roles
///
/// Encapsula la lista de usuarios y metadatos adicionales de la respuesta.
class UsersByRolesResponse {
  final List<UserByRoleModel> users;
  final int total;
  final Map<String, dynamic>? metadata;

  const UsersByRolesResponse({
    required this.users,
    required this.total,
    this.metadata,
  });

  /// Crea una instancia desde un Map JSON o List JSON
  factory UsersByRolesResponse.fromJson(dynamic json) {
    List<dynamic> usersData;
    int totalCount;

    if (json is List) {
      // Respuesta directa como array (caso actual de la API)
      usersData = json;
      totalCount = usersData.length;
    } else if (json is Map<String, dynamic>) {
      // Maneja diferentes estructuras de respuesta posibles
      if (json.containsKey('data') && json['data'] is List) {
        // Estructura: {"data": [...], "total": 10}
        usersData = json['data'] as List<dynamic>;
        totalCount = json['total'] as int? ?? usersData.length;
      } else if (json.containsKey('users') && json['users'] is List) {
        // Estructura: {"users": [...], "total": 10}
        usersData = json['users'] as List<dynamic>;
        totalCount = json['total'] as int? ?? usersData.length;
      } else {
        // Fallback: respuesta vacía
        usersData = [];
        totalCount = 0;
      }
    } else {
      // Fallback para cualquier otro caso
      usersData = [];
      totalCount = 0;
    }

    final users = usersData.map((userJson) => UserByRoleModel.fromJson(userJson as Map<String, dynamic>)).toList();

    return UsersByRolesResponse(
      users: users,
      total: totalCount,
    );
  }

  /// Convierte la instancia a un Map JSON
  Map<String, dynamic> toJson() {
    final result = {
      'users': users.map((user) => user.toJson()).toList(),
      'total': total,
    };

    if (metadata != null) {
      metadata!.forEach((key, value) {
        result[key] = value;
      });
    }

    return result;
  }

  /// Indica si la respuesta contiene usuarios
  bool get hasUsers => users.isNotEmpty;

  /// Obtiene usuarios filtrados por rol específico
  List<UserByRoleModel> getUsersByRole(String role) {
    return users.where((user) => user.role == role).toList();
  }

  /// Obtiene usuarios que tienen autenticación social configurada
  List<UserByRoleModel> getUsersWithSocialAuth() {
    return users.where((user) => user.socialToken != null || user.firebaseProvider != null).toList();
  }

  /// Obtiene usuarios con email verificado
  List<UserByRoleModel> getUsersWithVerifiedEmail() {
    return users.where((user) => user.isEmailVerified == true).toList();
  }

  /// Obtiene usuarios que necesitan cambiar contraseña
  List<UserByRoleModel> getUsersNeedingPasswordChange() {
    return users.where((user) => user.needToChangepassword == true).toList();
  }

  /// Obtiene usuarios con membresía activa
  List<UserByRoleModel> getUsersWithMembership() {
    return users.where((user) => user.membership != null).toList();
  }

  @override
  String toString() {
    return 'UsersByRolesResponse(total: $total, users: ${users.length})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UsersByRolesResponse && other.total == total && other.users.length == users.length;
  }

  @override
  int get hashCode {
    return total.hashCode ^ users.length.hashCode;
  }
}
