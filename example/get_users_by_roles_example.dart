import 'package:menu_dart_api/menu_com_api.dart';

/// Ejemplos de uso para el caso de uso GetUsersByRoles
///
/// Este archivo muestra diferentes formas de utilizar la funcionalidad
/// de consulta de usuarios por roles.

void main() async {
  // Configurar la API (esto normalmente se hace al inicio de la app)
  API.getInstance('http://localhost:3001');
  API.setAccessToken('tu_token_aqui');

  await ejemploBasico();
  await ejemploConCuentasVinculadas();
  await ejemploConMultiplesRoles();
  await ejemploManejoDeErrores();
}

/// Ejemplo básico de consulta de usuarios por rol
Future<void> ejemploBasico() async {
  print('=== Ejemplo Básico ===');

  final useCase = GetUsersByRolesUseCase();
  final params = UsersByRolesParams(
    roles: [RolesUsers.dinning],
    withVinculedAccount: false,
  );

  try {
    final response = await useCase.execute(params);
    print('Usuarios encontrados: ${response.total}');

    for (final user in response.users) {
      print('- ${user.name} (${user.email}) - Rol: ${user.role}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

/// Ejemplo de consulta incluyendo información de autenticación
Future<void> ejemploConCuentasVinculadas() async {
  print('\n=== Ejemplo con Información de Autenticación ===');

  final useCase = GetUsersByRolesUseCase();
  final params = UsersByRolesParams(
    roles: [RolesUsers.dinning, RolesUsers.clothes],
    withVinculedAccount: true,
  );

  try {
    final response = await useCase.execute(params);
    print('Usuarios encontrados: ${response.total}');

    // Filtrar usuarios con autenticación social
    final usuariosConAuth = response.getUsersWithSocialAuth();
    print('Usuarios con autenticación social: ${usuariosConAuth.length}');

    for (final user in usuariosConAuth) {
      print('- ${user.name} tiene auth social: ${user.socialToken != null || user.firebaseProvider != null}');
    }

    // Filtrar usuarios con email verificado
    final usuariosEmailVerificado = response.getUsersWithVerifiedEmail();
    print('Usuarios con email verificado: ${usuariosEmailVerificado.length}');

    for (final user in usuariosEmailVerificado) {
      print('- ${user.name} email verificado: ${user.isEmailVerified}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

/// Ejemplo de consulta con múltiples roles
Future<void> ejemploConMultiplesRoles() async {
  print('\n=== Ejemplo con Múltiples Roles ===');

  final useCase = GetUsersByRolesUseCase();
  final params = UsersByRolesParams(
    roles: [
      RolesUsers.dinning,
      RolesUsers.clothes,
      RolesUsers.admin,
    ],
    withVinculedAccount: true,
  );

  try {
    final response = await useCase.execute(params);
    print('Total de usuarios: ${response.total}');

    // Agrupar por rol
    final usuariosPorRol = <String, List<UserByRoleModel>>{};
    for (final user in response.users) {
      final rol = user.role ?? 'sin_rol';
      usuariosPorRol.putIfAbsent(rol, () => []).add(user);
    }

    usuariosPorRol.forEach((rol, usuarios) {
      print('Rol $rol: ${usuarios.length} usuarios');
      for (final user in usuarios) {
        print('  - ${user.name} (${user.email})');
      }
    });
  } catch (e) {
    print('Error: $e');
  }
}

/// Ejemplo de manejo de errores
Future<void> ejemploManejoDeErrores() async {
  print('\n=== Ejemplo de Manejo de Errores ===');

  final useCase = GetUsersByRolesUseCase();

  // Caso 1: Lista vacía de roles (debería lanzar ArgumentError)
  try {
    final params = UsersByRolesParams(roles: []);
    await useCase.execute(params);
  } catch (e) {
    print('Error esperado con lista vacía: ${e.runtimeType} - $e');
  }

  // Caso 2: Error de API (simular token inválido)
  try {
    final originalToken = API.loginAccessToken;
    API.setAccessToken('token_invalido');

    final params = UsersByRolesParams(
      roles: [RolesUsers.dinning],
    );

    await useCase.execute(params);

    // Restaurar token original
    API.setAccessToken(originalToken);
  } catch (e) {
    print('Error de autenticación: ${e.runtimeType} - $e');
  }
}

/// Ejemplo de uso con factory methods para casos comunes
class UsersByRolesHelper {
  /// Obtiene todos los usuarios administradores
  static Future<UsersByRolesResponse> getAdmins() async {
    final useCase = GetUsersByRolesUseCase();
    final params = UsersByRolesParams(
      roles: [RolesUsers.admin],
      withVinculedAccount: false,
    );
    return await useCase.execute(params);
  }

  /// Obtiene usuarios de comida (dinning) con información de autenticación
  static Future<UsersByRolesResponse> getDinningUsersWithAuthInfo() async {
    final useCase = GetUsersByRolesUseCase();
    final params = UsersByRolesParams(
      roles: [RolesUsers.dinning],
      withVinculedAccount: true,
    );
    return await useCase.execute(params);
  }

  /// Obtiene usuarios de ropa (clothes)
  static Future<UsersByRolesResponse> getClothesUsers() async {
    final useCase = GetUsersByRolesUseCase();
    final params = UsersByRolesParams(
      roles: [RolesUsers.clothes],
      withVinculedAccount: false,
    );
    return await useCase.execute(params);
  }

  /// Obtiene usuarios con email verificado por rol
  static Future<List<UserByRoleModel>> getVerifiedUsersByRole(RolesUsers role) async {
    final useCase = GetUsersByRolesUseCase();
    final params = UsersByRolesParams(
      roles: [role],
      withVinculedAccount: true,
    );
    final response = await useCase.execute(params);
    return response.getUsersWithVerifiedEmail();
  }

  /// Obtiene usuarios que necesitan cambiar contraseña
  static Future<List<UserByRoleModel>> getUsersNeedingPasswordChange() async {
    final useCase = GetUsersByRolesUseCase();
    final params = UsersByRolesParams(
      roles: RolesUsers.values, // Todos los roles
      withVinculedAccount: true,
    );
    final response = await useCase.execute(params);
    return response.getUsersNeedingPasswordChange();
  }
}
