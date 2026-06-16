class UpdateRoleRequest {
  final bool? isActive;
  final String? expiresAt;
  final Map<String, dynamic>? metadata;

  UpdateRoleRequest({this.isActive, this.expiresAt, this.metadata});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (isActive != null) map['isActive'] = isActive;
    if (expiresAt != null) map['expiresAt'] = expiresAt;
    if (metadata != null) map['metadata'] = metadata;
    return map;
  }
}
