class UpdateUserRoleResponse {
  final bool success;
  final String? message;
  final String? role;

  UpdateUserRoleResponse({
    required this.success,
    this.message,
    this.role,
  });

  factory UpdateUserRoleResponse.fromJson(Map<String, dynamic> json) {
    // El API retorna {"message": "...", "data": {"userRole": "...", "userRolesUpdated": true}}
    final data = json['data'] as Map<String, dynamic>?;
    final userRolesUpdated = data?['userRolesUpdated'] == true;
    final userRole = data?['userRole'] as String?;

    return UpdateUserRoleResponse(
      success: userRolesUpdated || json['success'] == true || json['success'] == 'true',
      message: json['message'] as String?,
      role: userRole ?? json['role'] as String?,
    );
  }

  factory UpdateUserRoleResponse.error(String message) {
    return UpdateUserRoleResponse(
      success: false,
      message: message,
    );
  }
}