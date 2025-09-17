import 'model/update_fcm_token_request.dart';
import 'data/repository/update_fcm_token_repository.dart';

/// Caso de uso para actualizar el FCM token del usuario
class UpdateFcmTokenUseCase {
  final UpdateFcmTokenRepository repository;

  UpdateFcmTokenUseCase(this.repository);

  Future<void> execute({
    required String fcmToken,
  }) async {
    final request = UpdateFcmTokenRequest(fcmToken: fcmToken);
    await repository.updateFcmToken(request);
  }
}
