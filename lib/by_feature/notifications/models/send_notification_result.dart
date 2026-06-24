/// Resultado de un envío de notificaciones a múltiples usuarios.
class SendNotificationResult {
  final int successCount;
  final int failureCount;

  SendNotificationResult({
    required this.successCount,
    required this.failureCount,
  });

  factory SendNotificationResult.fromJson(Map<String, dynamic> json) {
    final results = json['results'] is Map<String, dynamic>
        ? json['results'] as Map<String, dynamic>
        : json;
    return SendNotificationResult(
      successCount: (results['successCount'] as num?)?.toInt() ?? 0,
      failureCount: (results['failureCount'] as num?)?.toInt() ?? 0,
    );
  }
}

/// DTO para enviar una notificación directa (sin template).
class SendAdminNotificationParams {
  final List<String> userIds;
  final String title;
  final String body;
  final Map<String, dynamic>? data;
  final String? imageUrl;

  SendAdminNotificationParams({
    required this.userIds,
    required this.title,
    required this.body,
    this.data,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'userIds': userIds,
      'title': title,
      'body': body,
    };
    if (data != null) map['data'] = data;
    if (imageUrl != null) map['imageUrl'] = imageUrl;
    return map;
  }
}

/// DTO para enviar una notificación desde un template con parámetros.
class SendFromTemplateParams {
  final List<String> userIds;
  final Map<String, String> params;

  SendFromTemplateParams({
    required this.userIds,
    required this.params,
  });

  Map<String, dynamic> toJson() {
    return {
      'userIds': userIds,
      'params': params,
    };
  }
}

/// Respuesta del envío desde template (incluye placeholders resueltos y diagnósticos).
class SendFromTemplateResult {
  final bool success;
  final String templateUsed;
  final String resolvedTitle;
  final String resolvedBody;
  final String? resolvedDeepLink;
  final Map<String, dynamic> resolvedData;
  final List<String>? unresolvedPlaceholders;
  final String? warning;
  final SendNotificationResult results;

  SendFromTemplateResult({
    required this.success,
    required this.templateUsed,
    required this.resolvedTitle,
    required this.resolvedBody,
    this.resolvedDeepLink,
    required this.resolvedData,
    this.unresolvedPlaceholders,
    this.warning,
    required this.results,
  });

  factory SendFromTemplateResult.fromJson(Map<String, dynamic> json) {
    final resolvedData = json['resolvedData'] is Map<String, dynamic>
        ? Map<String, dynamic>.from(json['resolvedData'] as Map)
        : <String, dynamic>{};

    final unresolved = json['unresolvedPlaceholders'] is List
        ? (json['unresolvedPlaceholders'] as List)
            .map((e) => e.toString())
            .toList()
        : null;

    final results = SendNotificationResult.fromJson(json);

    return SendFromTemplateResult(
      success: json['success'] ?? true,
      templateUsed: json['templateUsed']?.toString() ?? '',
      resolvedTitle: json['resolvedTitle']?.toString() ?? '',
      resolvedBody: json['resolvedBody']?.toString() ?? '',
      resolvedDeepLink: json['resolvedDeepLink']?.toString(),
      resolvedData: resolvedData,
      unresolvedPlaceholders: unresolved,
      warning: json['warning']?.toString(),
      results: results,
    );
  }

  /// true si hubo placeholders sin resolver.
  bool get hasUnresolvedPlaceholders =>
      unresolvedPlaceholders != null && unresolvedPlaceholders!.isNotEmpty;
}
