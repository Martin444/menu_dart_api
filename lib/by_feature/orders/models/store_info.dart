class StoreInfo {
  final String? id;
  final String? businessName;
  final String? slug;
  final String? coverImageUrl;
  final String? businessPhone;
  final String? businessAddress;

  StoreInfo({
    this.id,
    this.businessName,
    this.slug,
    this.coverImageUrl,
    this.businessPhone,
    this.businessAddress,
  });

  factory StoreInfo.fromJson(Map<String, dynamic> json) {
    return StoreInfo(
      id: json['id']?.toString(),
      businessName: json['businessName']?.toString(),
      slug: json['slug']?.toString(),
      coverImageUrl: json['coverImageUrl']?.toString(),
      businessPhone: json['businessPhone']?.toString(),
      businessAddress: json['businessAddress']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'id': id,
      'businessName': businessName,
      'slug': slug,
      'coverImageUrl': coverImageUrl,
      'businessPhone': businessPhone,
      'businessAddress': businessAddress,
    };
    data.removeWhere((key, value) => value == null);
    return data;
  }
}
