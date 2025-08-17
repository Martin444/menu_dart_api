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
      createAt: _parseDateTime(json['createAt']),
      updateAt: _parseDateTime(json['updateAt']),
    );
  }

  // Método helper para parsear DateTime desde diferentes formatos
  static DateTime? _parseDateTime(dynamic dateValue) {
    if (dateValue == null) return null;

    try {
      if (dateValue is String) {
        return DateTime.parse(dateValue);
      } else if (dateValue is Map<String, dynamic>) {
        // Si viene como objeto JSON, buscar la fecha en diferentes propiedades
        final dateString = dateValue['date'] ?? dateValue['value'] ?? dateValue['datetime'] ?? dateValue['timestamp'];
        if (dateString is String) {
          return DateTime.parse(dateString);
        }
      }
    } catch (e) {
      // Si hay error en el parsing, retornar null
      return null;
    }

    return null;
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
