import 'dart:typed_data';

class CreateCommerceRequest {
  final String businessName;
  final String slug;
  final String? businessType;
  final String context;
  final String? description;
  final String? address;
  final String? phone;
  final bool? isActive;
  final Map<String, dynamic>? metadata;
  final Uint8List? logoBytes;
  final Uint8List? coverImageBytes;

  CreateCommerceRequest({
    required this.businessName,
    required this.slug,
    this.businessType,
    required this.context,
    this.description,
    this.address,
    this.phone,
    this.isActive,
    this.metadata,
    this.logoBytes,
    this.coverImageBytes,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'businessName': businessName,
      'slug': slug,
      'context': context,
    };
    if (businessType != null) map['businessType'] = businessType;
    if (description != null) map['description'] = description;
    if (address != null) map['address'] = address;
    if (phone != null) map['phone'] = phone;
    if (isActive != null) map['isActive'] = isActive;
    if (metadata != null) map['metadata'] = metadata;
    return map;
  }
}

class UpdateCommerceRequest {
  final String? businessName;
  final String? slug;
  final String? businessType;
  final String? context;
  final String? description;
  final String? address;
  final String? phone;
  final bool? isActive;
  final Map<String, dynamic>? metadata;
  final Uint8List? logoBytes;
  final Uint8List? coverImageBytes;

  UpdateCommerceRequest({
    this.businessName,
    this.slug,
    this.businessType,
    this.context,
    this.description,
    this.address,
    this.phone,
    this.isActive,
    this.metadata,
    this.logoBytes,
    this.coverImageBytes,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (businessName != null) map['businessName'] = businessName;
    if (slug != null) map['slug'] = slug;
    if (businessType != null) map['businessType'] = businessType;
    if (context != null) map['context'] = context;
    if (description != null) map['description'] = description;
    if (address != null) map['address'] = address;
    if (phone != null) map['phone'] = phone;
    if (isActive != null) map['isActive'] = isActive;
    if (metadata != null) map['metadata'] = metadata;
    return map;
  }
}
