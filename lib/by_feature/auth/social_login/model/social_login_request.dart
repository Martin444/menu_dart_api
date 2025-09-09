/// Modelo para enviar datos de autenticación social al backend.
///
/// Este modelo encapsula el token de Firebase ID que será validado
/// por el backend para autenticar al usuario.
class SocialLoginRequest {
  /// Token de ID de Firebase obtenido después del sign-in social
  final String firebaseIdToken;

  /// Datos adicionales del usuario obtenidos durante el proceso social
  final Map<String, dynamic>? additionalData;

  const SocialLoginRequest({
    required this.firebaseIdToken,
    this.additionalData,
  });

  /// Crea una instancia desde JSON
  factory SocialLoginRequest.fromJson(Map<String, dynamic> json) {
    return SocialLoginRequest(
      firebaseIdToken: json['firebaseIdToken'] as String,
      additionalData: json['additionalData'] as Map<String, dynamic>?,
    );
  }

  /// Convierte la instancia a JSON para la API
  Map<String, dynamic> toJson() {
    return {
      'firebaseIdToken': firebaseIdToken,
      if (additionalData != null) 'additionalData': additionalData,
    };
  }

  @override
  String toString() {
    return 'SocialLoginRequest(firebaseIdToken: [REDACTED], hasAdditionalData: ${additionalData != null})';
  }
}
