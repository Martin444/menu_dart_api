import 'package:menu_dart_api/by_feature/notifications/data/provider/notification_provider.dart';
import 'package:menu_dart_api/by_feature/notifications/data/repository/notification_repository.dart';
import 'package:menu_dart_api/by_feature/notifications/models/notification_template_model.dart';

/// Caso de uso: actualizar un template de notificación.
///
/// Endpoint: PATCH /notifications/admin/templates/:id
class UpdateNotificationTemplateUseCase {
  final NotificationRepository _repository;

  UpdateNotificationTemplateUseCase({NotificationRepository? repository})
      : _repository = repository ?? NotificationProvider();

  Future<NotificationTemplateModel> call(
      String id, UpdateNotificationTemplateParams params) async {
    return await _repository.updateTemplate(id, params);
  }
}
