# Get Users By Roles API

Esta funcionalidad permite obtener usuarios filtrados por roles específicos, con la opción de incluir información sobre cuentas vinculadas.

## Endpoint

```
POST /user/by-roles
```

## Estructura de la Request

```json
{
  "roles": ["dinning", "clothes"],
  "withVinculedAccount": true
}
```

## Estructura de la Response

```json
[
  {
    "id": "4f93bf4c-13c5-4291-95ba-883dee004fe7",
    "photoURL": "http://localhost:3000/api/image-proxy/image?url=...",
    "name": "Cousin Vintage",
    "email": "cousinvintrage@test.com",
    "phone": "37382723803",
    "needToChangepassword": false,
    "role": "clothes",
    "socialToken": null,
    "firebaseProvider": null,
    "isEmailVerified": false,
    "lastLoginAt": null,
    "createAt": {},
    "updateAt": {},
    "membership": null
  },
  {
    "id": "0478806e-938d-4ffa-8629-5f0eeb95bdfd",
    "photoURL": "http://localhost:3000/api/image-proxy/image?url=...",
    "name": "Cousin Test",
    "email": "test@test.com",
    "phone": "0934092349023",
    "needToChangepassword": false,
    "role": "clothes",
    "socialToken": null,
    "firebaseProvider": null,
    "isEmailVerified": false,
    "lastLoginAt": null,
    "createAt": {},
    "updateAt": {},
    "membership": null
  }
]
```

## Uso en Flutter/Dart

### Importación

```dart
import 'package:menu_dart_api/menu_com_api.dart';
```

### Configuración inicial

```dart
void main() {
  // Configurar la API
  API.getInstance('http://localhost:3001');
  API.setAccessToken('tu_bearer_token');
}
```

### Ejemplo básico

```dart
Future<void> obtenerUsuariosPorRoles() async {
  final useCase = GetUsersByRolesUseCase();
  
  final params = UsersByRolesParams(
    roles: [RolesUsers.dinning, RolesUsers.clothes],
    withVinculedAccount: true,
  );

  try {
    final response = await useCase.execute(params);
    
    print('Total de usuarios: ${response.total}');
    
    for (final user in response.users) {
      print('${user.name} - ${user.role}');
      if (user.isEmailVerified == true) {
        print('  Email verificado');
      }
      if (user.socialToken != null) {
        print('  Tiene autenticación social');
      }
    }
  } catch (e) {
    print('Error: $e');
  }
}
```

### Métodos auxiliares de UsersByRolesResponse

```dart
// Verificar si hay usuarios en la respuesta
bool hasUsers = response.hasUsers;

// Obtener usuarios de un rol específico
List<UserByRoleModel> dinningUsers = response.getUsersByRole('dinning');

// Obtener usuarios con autenticación social
List<UserByRoleModel> socialUsers = response.getUsersWithSocialAuth();

// Obtener usuarios con email verificado
List<UserByRoleModel> verifiedUsers = response.getUsersWithVerifiedEmail();

// Obtener usuarios que necesitan cambiar contraseña
List<UserByRoleModel> needPasswordChange = response.getUsersNeedingPasswordChange();

// Obtener usuarios con membresía activa
List<UserByRoleModel> usersWithMembership = response.getUsersWithMembership();
```

### Manejo de errores

```dart
try {
  final response = await useCase.execute(params);
  // Procesar respuesta
} on ApiException catch (e) {
  // Error de la API (código de estado HTTP != 200)
  print('Error de API: ${e.statusCode} - ${e.message}');
} on ArgumentError catch (e) {
  // Error de validación de parámetros
  print('Error de parámetros: $e');
} catch (e) {
  // Otros errores (red, parsing, etc.)
  print('Error general: $e');
}
```

## Roles disponibles

Los roles están definidos en el enum `RolesUsers`:

- `RolesUsers.clothes` - Usuarios de ropa
- `RolesUsers.dinning` - Usuarios de comida
- `RolesUsers.customer` - Clientes
- `RolesUsers.admin` - Administradores

## Campos del modelo UserByRoleModel

El modelo `UserByRoleModel` incluye todos los campos retornados por la API real:

```dart
class UserByRoleModel {
  final String? id;                    // ID único del usuario
  final String? photoURL;              // URL de la foto de perfil
  final String? name;                  // Nombre del usuario
  final String? email;                 // Email del usuario
  final String? phone;                 // Teléfono del usuario
  final bool? needToChangepassword;    // Indica si necesita cambiar contraseña
  final String? role;                  // Rol del usuario (dinning, clothes, admin, customer)
  final String? socialToken;           // Token de autenticación social
  final String? firebaseProvider;      // Proveedor de Firebase (google, facebook, etc.)
  final bool? isEmailVerified;         // Indica si el email está verificado
  final DateTime? lastLoginAt;         // Fecha del último login
  final DateTime? createAt;            // Fecha de creación
  final DateTime? updateAt;            // Fecha de última actualización
  final Map<String, dynamic>? membership; // Información de membresía
}
```

## Casos de uso comunes

### 1. Obtener solo administradores

```dart
final params = UsersByRolesParams(
  roles: [RolesUsers.admin],
  withVinculedAccount: false,
);
```

### 2. Obtener usuarios de comida con email verificado

```dart
final params = UsersByRolesParams(
  roles: [RolesUsers.dinning],
  withVinculedAccount: true,
);

final response = await useCase.execute(params);
final verifiedUsers = response.getUsersWithVerifiedEmail();
```

### 3. Obtener usuarios de múltiples roles

```dart
final params = UsersByRolesParams(
  roles: [
    RolesUsers.dinning,
    RolesUsers.clothes,
    RolesUsers.customer,
  ],
  withVinculedAccount: true,
);
```

## Arquitectura

La implementación sigue el patrón Clean Architecture:

```
lib/by_feature/user/get_users_by_roles/
├── model/
│   ├── users_by_roles_params.dart      # Parámetros de entrada
│   ├── user_by_role_model.dart         # Modelo de usuario individual
│   └── users_by_roles_response.dart    # Respuesta completa
├── data/
│   ├── repository/
│   │   └── users_by_roles_repository.dart  # Contrato abstracto
│   ├── provider/
│   │   └── users_by_roles_provider.dart    # Implementación HTTP
│   └── usescase/
│       └── get_users_by_roles_usecase.dart # Lógica de negocio
```

## Testing

Para probar la funcionalidad, revisa el archivo de ejemplo:
`menu_dart_api/example/get_users_by_roles_example.dart`

## Validaciones

- La lista de roles no puede estar vacía
- Se requiere un token de autorización válido
- El endpoint requiere autenticación Bearer

## Notas sobre la respuesta

- La API retorna un **array directo** de usuarios, no un objeto con propiedades `users` y `total`
- El campo `total` se calcula automáticamente como la longitud del array
- Los campos `createAt` y `updateAt` pueden venir como objetos vacíos `{}` en algunos casos
- El parsing de fechas es robusto y maneja diferentes formatos
- La respuesta incluye información detallada de autenticación y estado del usuario
