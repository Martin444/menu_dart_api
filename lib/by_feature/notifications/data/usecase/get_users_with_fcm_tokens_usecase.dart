import 'package:menu_dart_api/by_feature/notifications/data/provider/notification_provider.dart';
import 'package:menu_dart_api/by_feature/notifications/data/repository/notification_repository.dart';
import 'package:menu_dart_api/by_feature/notifications/models/user_with_fcm_token.dart';

/// Caso de uso: listar usuarios con FCM token registrado (paginado, con búsqueda).
///
/// Endpoint: GET /notifications/admin/users-with-tokens
class GetUsersWithFcmTokensUseCase {
  final NotificationRepository _repository;

  GetUsersWithFcmTokensUseCase({NotificationRepository? repository})
      : _repository = repository ?? NotificationProvider();

  Future<PaginatedUsersWithTokensResponse> call(
      ListUsersWithTokensParams params) async {
    return await _repository.getUsersWithTokens(params);
  }
}
