import 'package:menu_dart_api/by_feature/notifications/data/provider/notification_provider.dart';
import 'package:menu_dart_api/by_feature/notifications/data/repository/notification_repository.dart';
import 'package:menu_dart_api/by_feature/notifications/models/notification_template_model.dart';

/// Caso de uso: crear un template de notificación.
///
/// Endpoint: POST /notifications/admin/templates
class CreateNotificationTemplateUseCase {
  final NotificationRepository _repository;

  CreateNotificationTemplateUseCase({NotificationRepository? repository})
      : _repository = repository ?? NotificationProvider();

  Future<NotificationTemplateModel> call(
      CreateNotificationTemplateParams params) async {
    return await _repository.createTemplate(params);
  }
}
