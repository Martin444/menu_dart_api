/// Modelo para la respuesta de autenticación social del backend.
///
/// Encapsula los datos devueltos por el endpoint /auth/social/login
/// incluyendo el token de acceso y la información del usuario.
class SocialLoginResponse {
  /// Token de acceso JWT para el sistema
  final String accessToken;

  /// Token de refresh para renovar el accessToken
  final String? refreshToken;

  /// Información básica del usuario autenticado
  final SocialLoginUser? user;

  /// Indica si necesita cambiar contraseña (normalmente false para social)
  final bool needToChangePassword;

  /// Timestamp de expiración del token
  final DateTime? expiresAt;

  const SocialLoginResponse({
    required this.accessToken,
    this.refreshToken,
    this.user,
    this.needToChangePassword = false,
    this.expiresAt,
  });

  /// Crea una instancia desde JSON
  factory SocialLoginResponse.fromJson(Map<String, dynamic> json) {
    return SocialLoginResponse(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String?,
      user: json['user'] != null ? SocialLoginUser.fromJson(json['user'] as Map<String, dynamic>) : null,
      needToChangePassword: json['needToChangePassword'] as bool? ?? false,
      expiresAt: json['expires_at'] != null ? DateTime.parse(json['expires_at'] as String) : null,
    );
  }

  /// Convierte la instancia a JSON
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      if (refreshToken != null) 'refresh_token': refreshToken,
      if (user != null) 'user': user!.toJson(),
      'needToChangePassword': needToChangePassword,
      if (expiresAt != null) 'expires_at': expiresAt!.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'SocialLoginResponse(accessToken: [REDACTED], user: ${user?.email}, needToChangePassword: $needToChangePassword)';
  }
}

/// Información del usuario en la respuesta de social login
class SocialLoginUser {
  /// ID único del usuario en el sistema
  final String? id;

  /// Email del usuario
  final String? email;

  /// Nombre completo del usuario
  final String? name;

  /// URL de la foto de perfil
  final String? photoURL;

  /// Número de teléfono
  final String? phone;

  /// Rol del usuario en el sistema
  final String? role;

  /// Token social del proveedor (Google, Apple, etc.)
  final String? socialToken;

  /// Proveedor de Firebase utilizado
  final String? firebaseProvider;

  /// Indica si el email está verificado
  final bool? isEmailVerified;

  /// Timestamp del último login
  final DateTime? lastLoginAt;

  const SocialLoginUser({
    this.id,
    this.email,
    this.name,
    this.photoURL,
    this.phone,
    this.role,
    this.socialToken,
    this.firebaseProvider,
    this.isEmailVerified,
    this.lastLoginAt,
  });

  /// Crea una instancia desde JSON
  factory SocialLoginUser.fromJson(Map<String, dynamic> json) {
    return SocialLoginUser(
      id: json['id'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      photoURL: json['photoURL'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
      socialToken: json['socialToken'] as String?,
      firebaseProvider: json['firebaseProvider'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool?,
      lastLoginAt: json['lastLoginAt'] != null ? DateTime.parse(json['lastLoginAt'] as String) : null,
    );
  }

  /// Convierte la instancia a JSON
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (name != null) 'name': name,
      if (photoURL != null) 'photoURL': photoURL,
      if (phone != null) 'phone': phone,
      if (role != null) 'role': role,
      if (socialToken != null) 'socialToken': socialToken,
      if (firebaseProvider != null) 'firebaseProvider': firebaseProvider,
      if (isEmailVerified != null) 'isEmailVerified': isEmailVerified,
      if (lastLoginAt != null) 'lastLoginAt': lastLoginAt!.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'SocialLoginUser(id: $id, email: $email, name: $name, role: $role)';
  }
}
