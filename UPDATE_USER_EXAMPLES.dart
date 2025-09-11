import 'dart:typed_data';
import 'package:menu_dart_api/menu_com_api.dart';

/// Ejemplo práctico de cómo usar el endpoint de actualización de usuario
/// Este archivo muestra diferentes escenarios de uso común
class UpdateUserExamples {
  /// Inicializar la API (llamar una vez al inicio de la app)
  static void initializeAPI() {
    API.getInstance("http://localhost:3001");
    // El token se debe configurar después del login
    // API.setAccessToken("tu_bearer_token_aqui");
  }

  /// Ejemplo 1: Actualizar información básica sin foto
  static Future<void> updateBasicInfo() async {
    final updateUserUseCase = UpdateUserUseCase();

    final request = UpdateUserRequest(
      userId: "12dd8541-48f3-4639-be7e-5029bd338f88",
      name: "Nuevo Nombre",
      email: "nuevo@email.com",
      phone: "123456789",
      role: "admin",
      needToChangePassword: false,
    );

    try {
      final response = await updateUserUseCase.call(request);

      if (response.success) {
        print("✅ Usuario actualizado: ${response.message}");
        if (response.userData != null) {
          print("📄 Datos del usuario: ${response.userData}");
        }
      } else {
        print("❌ Error al actualizar: ${response.message}");
      }
    } on ApiException catch (e) {
      print("🚨 Error de API: ${e.toString()}");
    } catch (e) {
      print("💥 Error inesperado: $e");
    }
  }

  /// Ejemplo 2: Actualizar solo la foto de perfil
  static Future<void> updateProfilePhoto(Uint8List photoBytes) async {
    final updateUserUseCase = UpdateUserUseCase();

    final request = UpdateUserRequest(
      userId: "12dd8541-48f3-4639-be7e-5029bd338f88",
      photoBytes: photoBytes,
      photoFilename: "profile_${DateTime.now().millisecondsSinceEpoch}.jpg",
    );

    try {
      final response = await updateUserUseCase.call(request);

      if (response.success) {
        print("📸 Foto actualizada exitosamente!");
      } else {
        print("❌ Error al actualizar foto: ${response.message}");
      }
    } catch (e) {
      print("💥 Error: $e");
    }
  }

  /// Ejemplo 3: Actualización completa (texto + foto)
  static Future<void> completeUpdate(Uint8List? photoBytes) async {
    final updateUserUseCase = UpdateUserUseCase();

    final request = UpdateUserRequest(
      userId: "12dd8541-48f3-4639-be7e-5029bd338f88",
      name: "Remeras Patronales",
      email: "remeras@patronales.com",
      phone: "37382723803",
      role: "clothes",
      needToChangePassword: false,
      photoBytes: photoBytes,
      photoFilename: photoBytes != null ? "user_photo.jpg" : null,
    );

    try {
      final response = await updateUserUseCase.call(request);

      if (response.success) {
        print("🎉 Usuario completamente actualizado!");
        print("📝 Mensaje: ${response.message}");
      } else {
        print("❌ Falló la actualización: ${response.message}");
      }
    } catch (e) {
      print("💥 Error: $e");
    }
  }

  /// Ejemplo 4: Forzar cambio de contraseña
  static Future<void> forcePasswordChange(String userId) async {
    final updateUserUseCase = UpdateUserUseCase();

    final request = UpdateUserRequest(
      userId: userId,
      needToChangePassword: true,
    );

    try {
      final response = await updateUserUseCase.call(request);

      if (response.success) {
        print("🔐 Usuario marcado para cambio de contraseña");
      } else {
        print("❌ Error: ${response.message}");
      }
    } catch (e) {
      print("💥 Error: $e");
    }
  }

  /// Ejemplo 5: Cambiar rol de usuario
  static Future<void> changeUserRole(String userId, String newRole) async {
    final updateUserUseCase = UpdateUserUseCase();

    final request = UpdateUserRequest(
      userId: userId,
      role: newRole,
    );

    try {
      final response = await updateUserUseCase.call(request);

      if (response.success) {
        print("👤 Rol actualizado a: $newRole");
      } else {
        print("❌ Error al cambiar rol: ${response.message}");
      }
    } catch (e) {
      print("💥 Error: $e");
    }
  }

  /// Helper: Simular obtención de bytes de imagen
  /// En una app real, esto vendría de image_picker o similar
  static Future<Uint8List> getImageBytesFromFile(String imagePath) async {
    // Esto es solo un ejemplo - en una app real usarías:
    // File(imagePath).readAsBytes() o image_picker
    throw UnimplementedError('Implementar según tu método de selección de imágenes');
  }

  /// Ejemplo de uso completo con manejo de estados
  static Future<UpdateUserResponse> updateUserWithErrorHandling({
    required String userId,
    String? name,
    String? email,
    String? phone,
    String? role,
    bool? needToChangePassword,
    Uint8List? photoBytes,
  }) async {
    final updateUserUseCase = UpdateUserUseCase();

    final request = UpdateUserRequest(
      userId: userId,
      name: name,
      email: email,
      phone: phone,
      role: role,
      needToChangePassword: needToChangePassword,
      photoBytes: photoBytes,
      photoFilename: photoBytes != null ? "profile_${DateTime.now().millisecondsSinceEpoch}.jpg" : null,
    );

    try {
      return await updateUserUseCase.call(request);
    } on ApiException catch (e) {
      // Manejar errores específicos de la API
      switch (e.statusCode) {
        case 401:
          return UpdateUserResponse.error("Token expirado. Por favor inicia sesión nuevamente.");
        case 403:
          return UpdateUserResponse.error("No tienes permisos para actualizar este usuario.");
        case 404:
          return UpdateUserResponse.error("Usuario no encontrado.");
        case 400:
          return UpdateUserResponse.error("Datos inválidos: ${e.message}");
        case 500:
          return UpdateUserResponse.error("Error del servidor. Intenta más tarde.");
        default:
          return UpdateUserResponse.error("Error: ${e.message}");
      }
    } catch (e) {
      return UpdateUserResponse.error("Error de conexión: $e");
    }
  }
}

/// Clase helper para validaciones previas al envío
class UpdateUserValidator {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return null;

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email) ? null : "Email inválido";
  }

  static String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) return null;

    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{7,15}$');
    return phoneRegex.hasMatch(phone) ? null : "Teléfono inválido";
  }

  static String? validateRole(String? role) {
    if (role == null || role.isEmpty) return null;

    const validRoles = ['admin', 'user', 'clothes', 'waiter', 'chef'];
    return validRoles.contains(role) ? null : "Rol inválido";
  }

  static String? validatePhoto(Uint8List? photoBytes) {
    if (photoBytes == null) return null;

    // Verificar tamaño (ej: máximo 5MB)
    const maxSize = 5 * 1024 * 1024; // 5MB
    if (photoBytes.length > maxSize) {
      return "La imagen no puede superar los 5MB";
    }

    return null;
  }

  static Map<String, String> validateUpdateRequest(UpdateUserRequest request) {
    final errors = <String, String>{};

    final emailError = validateEmail(request.email);
    if (emailError != null) errors['email'] = emailError;

    final phoneError = validatePhone(request.phone);
    if (phoneError != null) errors['phone'] = phoneError;

    final roleError = validateRole(request.role);
    if (roleError != null) errors['role'] = roleError;

    final photoError = validatePhoto(request.photoBytes);
    if (photoError != null) errors['photo'] = photoError;

    return errors;
  }
}
