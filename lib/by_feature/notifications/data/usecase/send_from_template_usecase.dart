import 'package:menu_dart_api/by_feature/notifications/data/provider/notification_provider.dart';
import 'package:menu_dart_api/by_feature/notifications/data/repository/notification_repository.dart';
import 'package:menu_dart_api/by_feature/notifications/models/send_notification_result.dart';

/// Caso de uso: enviar notificación push desde un template con parámetros.
///
/// Endpoint: POST /notifications/admin/send-from-template/:templateId
///
/// El backend resuelve los placeholders {{key}} con los valores de [params],
/// valida límites de FCM y retorna diagnósticos (placeholders sin resolver, etc.).
class SendFromTemplateUseCase {
  final NotificationRepository _repository;

  SendFromTemplateUseCase({NotificationRepository? repository})
      : _repository = repository ?? NotificationProvider();

  Future<SendFromTemplateResult> call(
      String templateId, SendFromTemplateParams params) async {
    return await _repository.sendFromTemplate(templateId, params);
  }
}
