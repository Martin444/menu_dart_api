/// Información de paginación estándar para respuestas paginadas de notifications.
class NotificationPaginationInfo {
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  NotificationPaginationInfo({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory NotificationPaginationInfo.fromJson(Map<String, dynamic> json) {
    return NotificationPaginationInfo(
      total: (json['total'] as num?)?.toInt() ?? 0,
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 20,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 1,
    );
  }
}

/// Filtros para listar templates de notificación.
class ListTemplatesParams {
  final int? page;
  final int? limit;
  final String? search;
  final bool? isActive;
  final String? sortBy;
  final String? sortOrder;

  ListTemplatesParams({
    this.page,
    this.limit,
    this.search,
    this.isActive,
    this.sortBy,
    this.sortOrder,
  });

  Map<String, String> toQueryParams() {
    final params = <String, String>{};
    if (page != null) params['page'] = page.toString();
    if (limit != null) params['limit'] = limit.toString();
    if (search != null && search!.isNotEmpty) params['search'] = search!;
    if (isActive != null) params['isActive'] = isActive.toString();
    if (sortBy != null) params['sortBy'] = sortBy!;
    if (sortOrder != null) params['sortOrder'] = sortOrder!;
    return params;
  }
}

/// Respuesta paginada de templates de notificación.
class PaginatedTemplatesResponse {
  final List<NotificationTemplateListItem> data;
  final NotificationPaginationInfo meta;

  PaginatedTemplatesResponse({
    required this.data,
    required this.meta,
  });

  factory PaginatedTemplatesResponse.fromJson(Map<String, dynamic> json) {
    final list = <NotificationTemplateListItem>[];
    if (json['data'] is List) {
      for (final item in json['data'] as List) {
        if (item is Map<String, dynamic>) {
          list.add(NotificationTemplateListItem.fromJson(item));
        }
      }
    }

    final metaJson = json['meta'] is Map<String, dynamic>
        ? json['meta'] as Map<String, dynamic>
        : <String, dynamic>{};

    return PaginatedTemplatesResponse(
      data: list,
      meta: NotificationPaginationInfo.fromJson(metaJson),
    );
  }
}

/// Item de template en listado (incluye placeholderCount calculado).
class NotificationTemplateListItem {
  final String id;
  final String name;
  final String title;
  final String body;
  final String? deepLink;
  final Map<String, dynamic>? data;
  final String? imageUrl;
  final bool isActive;
  final int placeholderCount;
  final DateTime? updatedAt;

  NotificationTemplateListItem({
    required this.id,
    required this.name,
    required this.title,
    required this.body,
    this.deepLink,
    this.data,
    this.imageUrl,
    required this.isActive,
    required this.placeholderCount,
    this.updatedAt,
  });

  factory NotificationTemplateListItem.fromJson(Map<String, dynamic> json) {
    return NotificationTemplateListItem(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      deepLink: json['deepLink']?.toString(),
      data: json['data'] is Map<String, dynamic>
          ? json['data'] as Map<String, dynamic>
          : null,
      imageUrl: json['imageUrl']?.toString(),
      isActive: json['isActive'] ?? true,
      placeholderCount: (json['placeholderCount'] as num?)?.toInt() ?? 0,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
    );
  }
}
