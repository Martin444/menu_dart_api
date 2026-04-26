class UpdateUserRoleRequest {
  final String role;

  UpdateUserRoleRequest({
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'role': role,
    };
  }
}