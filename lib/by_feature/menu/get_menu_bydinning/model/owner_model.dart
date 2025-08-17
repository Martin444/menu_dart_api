class OwnerModel {
  String? id;
  String? photoURL;
  String? name;
  String? email;
  String? phone;
  String? role;
  DateTime? createAt;
  DateTime? updateAt;

  OwnerModel({
    this.id,
    this.photoURL,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.createAt,
    this.updateAt,
  });

  // fromJson
  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      id: json['id'] as String?,
      photoURL: json['photoURL'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
      createAt: json['createAt'] != null 
          ? DateTime.parse(json['createAt'] as String)
          : null,
      updateAt: json['updateAt'] != null 
          ? DateTime.parse(json['updateAt'] as String)
          : null,
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photoURL': photoURL,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'createAt': createAt?.toIso8601String(),
      'updateAt': updateAt?.toIso8601String(),
    };
  }
}
