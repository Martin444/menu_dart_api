import 'package:menu_dart_api/by_feature/notifications/data/provider/notification_provider.dart';
import 'package:menu_dart_api/by_feature/notifications/data/repository/notification_repository.dart';
import 'package:menu_dart_api/by_feature/notifications/models/notification_template_model.dart';

/// Caso de uso: obtener un template de notificación por ID.
///
/// Endpoint: GET /notifications/admin/templates/:id
class GetNotificationTemplateUseCase {
  final NotificationRepository _repository;

  GetNotificationTemplateUseCase({NotificationRepository? repository})
      : _repository = repository ?? NotificationProvider();

  Future<NotificationTemplateModel> call(String id) async {
    return await _repository.getTemplate(id);
  }
}
