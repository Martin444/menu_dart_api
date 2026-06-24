import 'package:menu_dart_api/by_feature/notifications/models/notification_template_model.dart';
import 'package:menu_dart_api/by_feature/notifications/models/paginated_templates_response.dart';
import 'package:menu_dart_api/by_feature/notifications/models/send_notification_result.dart';
import 'package:menu_dart_api/by_feature/notifications/models/user_with_fcm_token.dart';

/// Repositorio abstracto para operaciones de notificaciones admin (FCM push).
///
/// Espejo del lado del cliente de los endpoints backend:
///   GET/POST/PATCH/DELETE /notifications/admin/templates
///   GET  /notifications/admin/users-with-tokens
///   POST /notifications/admin/send
///   POST /notifications/admin/send-from-template/:id
abstract class NotificationRepository {
  // --- Templates CRUD ---

  /// Crear template (POST /notifications/admin/templates)
  Future<NotificationTemplateModel> createTemplate(
      CreateNotificationTemplateParams params);

  /// Listar templates paginado con filtros (GET /notifications/admin/templates)
  Future<PaginatedTemplatesResponse> listTemplates(ListTemplatesParams params);

  /// Obtener un template por ID (GET /notifications/admin/templates/:id)
  Future<NotificationTemplateModel> getTemplate(String id);

  /// Actualizar template (PATCH /notifications/admin/templates/:id)
  Future<NotificationTemplateModel> updateTemplate(
      String id, UpdateNotificationTemplateParams params);

  /// Soft-delete de template (DELETE /notifications/admin/templates/:id)
  Future<Map<String, dynamic>> deleteTemplate(String id);

  // --- Envío de notificaciones ---

  /// Notificación directa (POST /notifications/admin/send)
  Future<SendNotificationResult> sendDirectNotification(
      SendAdminNotificationParams params);

  /// Notificación desde template (POST /notifications/admin/send-from-template/:id)
  Future<SendFromTemplateResult> sendFromTemplate(
      String templateId, SendFromTemplateParams params);

  // --- Usuarios con FCM token ---

  /// Listar usuarios con FCM token (GET /notifications/admin/users-with-tokens)
  Future<PaginatedUsersWithTokensResponse> getUsersWithTokens(
      ListUsersWithTokensParams params);
}
