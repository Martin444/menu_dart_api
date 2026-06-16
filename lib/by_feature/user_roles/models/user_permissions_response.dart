class UserPermissionsResponse {
  final String userId;
  final String context;
  final List<String> permissions;

  UserPermissionsResponse({
    required this.userId,
    required this.context,
    required this.permissions,
  });

  factory UserPermissionsResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    return UserPermissionsResponse(
      userId: data['userId'] as String? ?? '',
      context: data['context'] as String? ?? '',
      permissions: (data['permissions'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}
