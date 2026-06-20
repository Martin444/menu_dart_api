class MyTeamResponse {
  final String commerceId;
  final List<TeamUser> users;

  MyTeamResponse({required this.commerceId, required this.users});

  factory MyTeamResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;
    return MyTeamResponse(
      commerceId: data['commerceId'] as String? ?? '',
      users: (data['users'] as List<dynamic>?)
              ?.map((e) => TeamUser.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class TeamUser {
  final String userId;
  final String name;
  final String email;
  final List<TeamUserRole> roles;

  TeamUser({
    required this.userId,
    required this.name,
    required this.email,
    required this.roles,
  });

  factory TeamUser.fromJson(Map<String, dynamic> json) {
    return TeamUser(
      userId: json['userId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      roles: (json['roles'] as List<dynamic>?)
              ?.map((e) => TeamUserRole.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class TeamUserRole {
  final String id;
  final String role;
  final String context;
  final bool isActive;
  final DateTime? grantedAt;

  TeamUserRole({
    required this.id,
    required this.role,
    required this.context,
    required this.isActive,
    this.grantedAt,
  });

  factory TeamUserRole.fromJson(Map<String, dynamic> json) {
    return TeamUserRole(
      id: json['id'] as String? ?? '',
      role: json['role'] as String? ?? '',
      context: json['context'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? true,
      grantedAt: json['grantedAt'] != null
          ? DateTime.tryParse(json['grantedAt'] as String)
          : null,
    );
  }
}
