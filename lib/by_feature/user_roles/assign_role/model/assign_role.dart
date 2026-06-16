class AssignRoleRequest {
  final String userId;
  final String role;
  final String context;
  final String? resourceId;
  final String? expiresAt;
  final Map<String, dynamic>? metadata;

  AssignRoleRequest({
    required this.userId,
    required this.role,
    required this.context,
    this.resourceId,
    this.expiresAt,
    this.metadata,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'role': role,
      'context': context,
      if (resourceId != null) 'resourceId': resourceId,
      if (expiresAt != null) 'expiresAt': expiresAt,
      if (metadata != null) 'metadata': metadata,
    };
  }
}

class AssignRoleResponse {
  final String message;
  final Map<String, dynamic>? data;

  AssignRoleResponse({required this.message, this.data});

  factory AssignRoleResponse.fromJson(Map<String, dynamic> json) {
    return AssignRoleResponse(
      message: json['message'] as String? ?? '',
      data: json['data'] as Map<String, dynamic>?,
    );
  }
}
