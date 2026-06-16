class UserRole {
  final String id;
  final String userId;
  final String role;
  final String context;
  final String? resourceId;
  final bool isActive;
  final String? grantedBy;
  final DateTime? expiresAt;
  final DateTime? grantedAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? metadata;

  UserRole({
    required this.id,
    required this.userId,
    required this.role,
    required this.context,
    this.resourceId,
    this.isActive = true,
    this.grantedBy,
    this.expiresAt,
    this.grantedAt,
    this.updatedAt,
    this.metadata,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      id: json['id'] as String,
      userId: json['userId'] as String,
      role: json['role'] as String,
      context: json['context'] as String,
      resourceId: json['resourceId'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      grantedBy: json['grantedBy'] as String?,
      expiresAt: json['expiresAt'] != null
          ? DateTime.tryParse(json['expiresAt'] as String)
          : null,
      grantedAt: json['grantedAt'] != null
          ? DateTime.tryParse(json['grantedAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'role': role,
      'context': context,
      if (resourceId != null) 'resourceId': resourceId,
      'isActive': isActive,
      if (grantedBy != null) 'grantedBy': grantedBy,
      if (expiresAt != null) 'expiresAt': expiresAt?.toIso8601String(),
      if (grantedAt != null) 'grantedAt': grantedAt?.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
      if (metadata != null) 'metadata': metadata,
    };
  }
}
