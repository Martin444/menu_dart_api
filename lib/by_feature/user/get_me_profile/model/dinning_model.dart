class DinningModel {
  String? id;
  String? photoURL;
  String? name;
  String? email;
  String? phone;
  String? role;
  DateTime? createAt;
  DateTime? updateAt;

  String? socialToken;
  String? firebaseProvider;
  bool isEmailVerified;
  DateTime? lastLoginAt;
  String? commerceId;
  String? businessName;
  String? slug;
  String? businessDescription;
  String? coverImageUrl;
  bool isFeatured;
  String? businessAddress;
  String? businessPhone;
  Map<String, dynamic>? socialLinks;
  Map<String, dynamic>? membership;
  bool needToChangepassword;
  String? fcmToken;

  DinningModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.createAt,
    this.updateAt,
    this.photoURL,
    this.socialToken,
    this.firebaseProvider,
    this.isEmailVerified = false,
    this.lastLoginAt,
    this.commerceId,
    this.businessName,
    this.slug,
    this.businessDescription,
    this.coverImageUrl,
    this.isFeatured = false,
    this.businessAddress,
    this.businessPhone,
    this.socialLinks,
    this.membership,
    this.needToChangepassword = false,
    this.fcmToken,
  });

  static DinningModel fromJson(Map<String, dynamic> json) {
    debugJson(json);

    return DinningModel(
      id: _extractString(json['id']),
      name: _extractString(json['name']) ?? 'Sin nombre',
      email: _extractString(json['email']),
      phone: _extractString(json['phone']),
      photoURL: _extractString(json['photoURL']),
      role: _extractString(json['role']),
      createAt: _parseDateTime(json['createdAt'] ?? json['createAt']),
      updateAt: _parseDateTime(json['updatedAt'] ?? json['updateAt']),
      socialToken: _extractString(json['socialToken']),
      firebaseProvider: _extractString(json['firebaseProvider']),
      isEmailVerified: json['isEmailVerified'] is bool
          ? json['isEmailVerified']
          : (json['isEmailVerified'] == 'true' || json['isEmailVerified'] == true),
      lastLoginAt: _parseDateTime(json['lastLoginAt']),
      commerceId: _extractString(json['commerceId']),
      businessName: _extractString(json['businessName']),
      slug: _extractString(json['slug']),
      businessDescription: _extractString(json['businessDescription']),
      coverImageUrl: _extractString(json['coverImageUrl']),
      isFeatured: json['isFeatured'] is bool
          ? json['isFeatured']
          : (json['isFeatured'] == 'true' || json['isFeatured'] == true),
      businessAddress: _extractString(json['businessAddress']),
      businessPhone: _extractString(json['businessPhone']),
      socialLinks: json['socialLinks'] as Map<String, dynamic>?,
      membership: json['membership'] as Map<String, dynamic>?,
      needToChangepassword: json['needToChangepassword'] is bool
          ? json['needToChangepassword']
          : (json['needToChangepassword'] == 'true' ||
              json['needToChangepassword'] == true),
      fcmToken: _extractString(json['fcmToken']),
    );
  }

  static String? _extractString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value.isEmpty ? null : value;
    if (value is Map && value.containsKey('value')) {
      return _extractString(value['value']);
    }
    return value.toString();
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        print('Error parsing date: $value - $e');
        return null;
      }
    }
    if (value is Map && value.containsKey('value')) {
      return _parseDateTime(value['value']);
    }
    return null;
  }

  static void debugJson(Map<String, dynamic> json) {
    print('=== DEBUG JSON STRUCTURE ===');
    json.forEach((key, value) {
      print('$key: ${value.runtimeType} = $value');
    });
    print('=== END DEBUG ===');
  }
}
