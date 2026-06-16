class SocialRegisterRequest {
  final String email;
  final String name;
  final String? phone;
  final String? role;
  final String? photoURL;

  SocialRegisterRequest({
    required this.email,
    required this.name,
    this.phone,
    this.role,
    this.photoURL,
  });

  factory SocialRegisterRequest.fromJson(Map<String, dynamic> json) {
    return SocialRegisterRequest(
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
      photoURL: json['photoURL'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      if (phone != null) 'phone': phone,
      if (role != null) 'role': role,
      if (photoURL != null) 'photoURL': photoURL,
    };
  }
}
