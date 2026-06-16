class RevokeRoleRequest {
  final String userId;
  final String role;
  final String context;
  final String? resourceId;

  RevokeRoleRequest({
    required this.userId,
    required this.role,
    required this.context,
    this.resourceId,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'role': role,
      'context': context,
      if (resourceId != null) 'resourceId': resourceId,
    };
  }
}
