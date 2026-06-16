class CommerceContext {
  final String id;
  final String businessName;
  final String slug;
  final String? context;
  final String? businessType;
  final String? logoUrl;
  final String? coverImageUrl;
  final String? role;
  final String? ownerId;
  final bool isActive;
  final bool isCurrent;
  final DateTime? createdAt;

  CommerceContext({
    required this.id,
    required this.businessName,
    required this.slug,
    this.context,
    this.businessType,
    this.logoUrl,
    this.coverImageUrl,
    this.role,
    this.ownerId,
    this.isActive = true,
    this.isCurrent = false,
    this.createdAt,
  });

  factory CommerceContext.fromJson(Map<String, dynamic> json) {
    return CommerceContext(
      id: json['id'] as String,
      businessName: json['businessName'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      context: json['context'] as String?,
      businessType: json['businessType'] as String?,
      logoUrl: json['logoUrl'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      role: json['role'] as String?,
      ownerId: json['ownerId'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      isCurrent: json['isCurrent'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'businessName': businessName,
      'slug': slug,
      if (context != null) 'context': context,
      if (businessType != null) 'businessType': businessType,
      if (logoUrl != null) 'logoUrl': logoUrl,
      if (coverImageUrl != null) 'coverImageUrl': coverImageUrl,
      if (role != null) 'role': role,
      if (ownerId != null) 'ownerId': ownerId,
      'isActive': isActive,
      'isCurrent': isCurrent,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
    };
  }
}
