import 'package:menu_dart_api/by_feature/notifications/data/provider/notification_provider.dart';
import 'package:menu_dart_api/by_feature/notifications/data/repository/notification_repository.dart';
import 'package:menu_dart_api/by_feature/notifications/models/paginated_templates_response.dart';

/// Caso de uso: listar templates de notificación (paginado, con filtros).
///
/// Endpoint: GET /notifications/admin/templates
class ListNotificationTemplatesUseCase {
  final NotificationRepository _repository;

  ListNotificationTemplatesUseCase({NotificationRepository? repository})
      : _repository = repository ?? NotificationProvider();

  Future<PaginatedTemplatesResponse> call(ListTemplatesParams params) async {
    return await _repository.listTemplates(params);
  }
}
