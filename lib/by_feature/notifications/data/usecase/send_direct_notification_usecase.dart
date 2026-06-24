import 'package:menu_dart_api/by_feature/notifications/data/provider/notification_provider.dart';
import 'package:menu_dart_api/by_feature/notifications/data/repository/notification_repository.dart';
import 'package:menu_dart_api/by_feature/notifications/models/send_notification_result.dart';

/// Caso de uso: enviar notificación push directa a uno o múltiples usuarios.
///
/// Endpoint: POST /notifications/admin/send
class SendDirectNotificationUseCase {
  final NotificationRepository _repository;

  SendDirectNotificationUseCase({NotificationRepository? repository})
      : _repository = repository ?? NotificationProvider();

  Future<SendNotificationResult> call(
      SendAdminNotificationParams params) async {
    return await _repository.sendDirectNotification(params);
  }
}
