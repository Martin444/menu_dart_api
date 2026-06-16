class Commerce {
  final String id;
  final String ownerId;
  final String businessName;
  final String slug;
  final String? businessType;
  final String? context;
  final String? logoUrl;
  final String? coverImageUrl;
  final String? description;
  final String? address;
  final String? phone;
  final bool isActive;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Commerce({
    required this.id,
    required this.ownerId,
    required this.businessName,
    required this.slug,
    this.businessType,
    this.context,
    this.logoUrl,
    this.coverImageUrl,
    this.description,
    this.address,
    this.phone,
    this.isActive = true,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  factory Commerce.fromJson(Map<String, dynamic> json) {
    return Commerce(
      id: json['id'] as String? ?? '',
      ownerId: json['ownerId'] as String? ?? '',
      businessName: json['businessName'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      businessType: json['businessType'] as String?,
      context: json['context'] as String?,
      logoUrl: json['logoUrl'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      description: json['description'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerId': ownerId,
      'businessName': businessName,
      'slug': slug,
      if (businessType != null) 'businessType': businessType,
      if (context != null) 'context': context,
      if (logoUrl != null) 'logoUrl': logoUrl,
      if (coverImageUrl != null) 'coverImageUrl': coverImageUrl,
      if (description != null) 'description': description,
      if (address != null) 'address': address,
      if (phone != null) 'phone': phone,
      'isActive': isActive,
      if (metadata != null) 'metadata': metadata,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }
}
