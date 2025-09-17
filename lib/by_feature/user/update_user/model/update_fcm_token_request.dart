/// Modelo para actualizar el FCM token del usuario
class UpdateFcmTokenRequest {
  final String fcmToken;

  UpdateFcmTokenRequest({required this.fcmToken});

  Map<String, dynamic> toJson() => {
        'fcmToken': fcmToken,
      };
}
