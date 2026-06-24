import 'package:menu_dart_api/by_feature/notifications/models/paginated_templates_response.dart';

/// Usuario con FCM token registrado (para envío de notificaciones push).
class UserWithFcmToken {
  final String id;
  final String name;
  final String email;
  final bool hasFcmToken;

  UserWithFcmToken({
    required this.id,
    required this.name,
    required this.email,
    this.hasFcmToken = true,
  });

  factory UserWithFcmToken.fromJson(Map<String, dynamic> json) {
    return UserWithFcmToken(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      hasFcmToken: json['hasFcmToken'] ?? true,
    );
  }
}

/// Respuesta paginada de usuarios con FCM token.
class PaginatedUsersWithTokensResponse {
  final List<UserWithFcmToken> data;
  final NotificationPaginationInfo meta;

  PaginatedUsersWithTokensResponse({
    required this.data,
    required this.meta,
  });

  factory PaginatedUsersWithTokensResponse.fromJson(
      Map<String, dynamic> json) {
    final list = <UserWithFcmToken>[];
    if (json['data'] is List) {
      for (final item in json['data'] as List) {
        if (item is Map<String, dynamic>) {
          list.add(UserWithFcmToken.fromJson(item));
        }
      }
    }

    final metaJson = json['meta'] is Map<String, dynamic>
        ? json['meta'] as Map<String, dynamic>
        : <String, dynamic>{};

    return PaginatedUsersWithTokensResponse(
      data: list,
      meta: NotificationPaginationInfo.fromJson(metaJson),
    );
  }
}

/// Parámetros para listar usuarios con FCM token.
class ListUsersWithTokensParams {
  final int? page;
  final int? limit;
  final String? search;

  ListUsersWithTokensParams({
    this.page,
    this.limit,
    this.search,
  });

  Map<String, String> toQueryParams() {
    final params = <String, String>{};
    if (page != null) params['page'] = page.toString();
    if (limit != null) params['limit'] = limit.toString();
    if (search != null && search!.isNotEmpty) params['search'] = search!;
    return params;
  }
}
