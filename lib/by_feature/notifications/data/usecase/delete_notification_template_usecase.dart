import 'package:menu_dart_api/by_feature/notifications/data/provider/notification_provider.dart';
import 'package:menu_dart_api/by_feature/notifications/data/repository/notification_repository.dart';

/// Caso de uso: desactivar (soft-delete) un template de notificación.
///
/// Endpoint: DELETE /notifications/admin/templates/:id
/// El backend setea isActive=false; no borra físicamente el registro.
class DeleteNotificationTemplateUseCase {
  final NotificationRepository _repository;

  DeleteNotificationTemplateUseCase({NotificationRepository? repository})
      : _repository = repository ?? NotificationProvider();

  Future<Map<String, dynamic>> call(String id) async {
    return await _repository.deleteTemplate(id);
  }
}
