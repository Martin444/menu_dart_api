/// Modelo que representa un template de notificación push (admin dashboard).
///
/// Espejo del lado del cliente de la entidad backend `NotificationTemplate`.
/// Ver docs/integration/admin-notifications-templates.md.
class NotificationTemplateModel {
  final String? id;
  final String name;
  final String title;
  final String body;
  final Map<String, dynamic>? data;
  final String? deepLink;
  final String? imageUrl;
  final bool isActive;
  final int? placeholderCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NotificationTemplateModel({
    this.id,
    required this.name,
    required this.title,
    required this.body,
    this.data,
    this.deepLink,
    this.imageUrl,
    this.isActive = true,
    this.placeholderCount,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationTemplateModel.fromJson(Map<String, dynamic> json) {
    return NotificationTemplateModel(
      id: json['id']?.toString(),
      name: json['name']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      data: json['data'] is Map<String, dynamic>
          ? json['data'] as Map<String, dynamic>
          : null,
      deepLink: json['deepLink']?.toString(),
      imageUrl: json['imageUrl']?.toString(),
      isActive: json['isActive'] ?? true,
      placeholderCount: json['placeholderCount'] is int
          ? json['placeholderCount'] as int
          : (json['placeholderCount'] is num
              ? (json['placeholderCount'] as num).toInt()
              : null),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'title': title,
      'body': body,
      if (data != null) 'data': data,
      if (deepLink != null) 'deepLink': deepLink,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'isActive': isActive,
    };
  }
}

/// DTO para crear un template de notificación.
class CreateNotificationTemplateParams {
  final String name;
  final String title;
  final String body;
  final Map<String, dynamic>? data;
  final String? deepLink;
  final String? imageUrl;

  CreateNotificationTemplateParams({
    required this.name,
    required this.title,
    required this.body,
    this.data,
    this.deepLink,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'name': name,
      'title': title,
      'body': body,
    };
    if (data != null) map['data'] = data;
    if (deepLink != null) map['deepLink'] = deepLink;
    if (imageUrl != null) map['imageUrl'] = imageUrl;
    return map;
  }
}

/// DTO para actualizar un template (todos los campos opcionales).
class UpdateNotificationTemplateParams {
  final String? name;
  final String? title;
  final String? body;
  final Map<String, dynamic>? data;
  final String? deepLink;
  final String? imageUrl;
  final bool? isActive;

  UpdateNotificationTemplateParams({
    this.name,
    this.title,
    this.body,
    this.data,
    this.deepLink,
    this.imageUrl,
    this.isActive,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (name != null) map['name'] = name;
    if (title != null) map['title'] = title;
    if (body != null) map['body'] = body;
    if (data != null) map['data'] = data;
    if (deepLink != null) map['deepLink'] = deepLink;
    if (imageUrl != null) map['imageUrl'] = imageUrl;
    if (isActive != null) map['isActive'] = isActive;
    return map;
  }
}
