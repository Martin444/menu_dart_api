# Update User Endpoint

Este módulo permite actualizar usuarios mediante el endpoint PATCH `/user/update/{userId}` con soporte para multipart/form-data.

## Características

- ✅ Soporte completo para multipart/form-data
- ✅ Subida de foto de perfil
- ✅ Actualización de campos de texto (name, email, phone, role, needToChangePassword)
- ✅ Manejo robusto de errores
- ✅ Headers de autorización automáticos

## Uso

```dart
import 'package:menu_dart_api/menu_com_api.dart';
import 'dart:typed_data';

// Configurar la API (solo una vez al inicio de la app)
API.getInstance("http://localhost:3001");
API.setAccessToken("tu_bearer_token_aqui");

// Crear el use case
final updateUserUseCase = UpdateUserUseCase();

// Ejemplo 1: Actualizar solo campos de texto
final textOnlyRequest = UpdateUserRequest(
  userId: "12dd8541-48f3-4639-be7e-5029bd338f88",
  name: "Remeras patronales",
  email: "remeras@patronales.com",
  phone: "37382723803",
  role: "clothes",
  needToChangePassword: false,
);

try {
  final response = await updateUserUseCase.call(textOnlyRequest);
  if (response.success) {
    print("Usuario actualizado exitosamente: ${response.message}");
  } else {
    print("Error: ${response.message}");
  }
} catch (e) {
  print("Error inesperado: $e");
}

// Ejemplo 2: Actualizar con foto
final Uint8List photoBytes = await getPhotoBytes(); // Tu método para obtener bytes de foto

final requestWithPhoto = UpdateUserRequest(
  userId: "12dd8541-48f3-4639-be7e-5029bd338f88",
  name: "Nuevo nombre",
  email: "nuevo@email.com",
  photoBytes: photoBytes,
  photoFilename: "profile_photo.jpg", // Opcional
);

try {
  final response = await updateUserUseCase.call(requestWithPhoto);
  if (response.success) {
    print("Usuario y foto actualizados: ${response.message}");
  } else {
    print("Error: ${response.message}");
  }
} catch (e) {
  print("Error inesperado: $e");
}
```

## Equivalente cURL

El endpoint corresponde exactamente a este cURL:

```bash
curl --location --request PATCH 'http://localhost:3001/user/update/12dd8541-48f3-4639-be7e-5029bd338f88' \
--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...' \
--form 'photo=@"/path/to/image.jpg"' \
--form 'name="Remeras patronales"' \
--form 'email="remeras@patronales.com"' \
--form 'phone="37382723803"' \
--form 'needToChangepassword="false"' \
--form 'role="clothes"'
```

## Campos Soportados

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `userId` | String | ID del usuario a actualizar (requerido) |
| `name` | String? | Nombre del usuario (opcional) |
| `email` | String? | Email del usuario (opcional) |
| `phone` | String? | Teléfono del usuario (opcional) |
| `role` | String? | Rol del usuario (opcional) |
| `needToChangePassword` | bool? | Si debe cambiar contraseña (opcional) |
| `photoBytes` | Uint8List? | Bytes de la foto de perfil (opcional) |
| `photoFilename` | String? | Nombre del archivo de foto (opcional) |

## Respuesta

La respuesta incluye:

```dart
class UpdateUserResponse {
  final bool success;           // true si la operación fue exitosa
  final String message;         // Mensaje descriptivo
  final Map<String, dynamic>? userData; // Datos del usuario actualizado (opcional)
}
```

## Manejo de Errores

El módulo maneja automáticamente:

- ❌ Errores de conexión
- ❌ Errores de autenticación (401)
- ❌ Errores del servidor (5xx)
- ❌ Errores de validación (4xx)
- ❌ Errores de formato de respuesta

Todos los errores se propagan como `ApiException` con código de estado y mensaje descriptivo.
