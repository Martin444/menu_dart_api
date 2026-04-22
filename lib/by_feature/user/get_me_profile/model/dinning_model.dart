import 'package:flutter/foundation.dart';

class DinningModel {
  String? id;
  String? photoURL;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? role;
  DateTime? createAt;
  DateTime? updateAt;

  DinningModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.role,
    this.createAt,
    this.updateAt,
    this.photoURL,
  });

  static DinningModel fromJson(Map<String, dynamic> json) {
    // Debuggea la estructura del JSON para identificar problemas
    debugJson(json);

    return DinningModel(
      id: _extractString(json['id']),
      name: _extractString(json['name']) ?? 'Sin nombre',
      email: _extractString(json['email']),
      phone: _extractString(json['phone']),
      photoURL: _extractString(json['photoURL']),
      role: _extractString(json['role']),
      createAt: _parseDateTime(json['createAt']),
      updateAt: _parseDateTime(json['updateAt']),
    );
  }

  // Método auxiliar para extraer strings de forma segura
  static String? _extractString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value.isEmpty ? null : value;
    if (value is Map && value.containsKey('value')) {
      return _extractString(value['value']);
    }
    // Si es un objeto, intenta convertirlo a string
    return value.toString();
  }

  // Método auxiliar para parsear fechas de forma segura
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

  // Método para debugging - te ayudará a ver la estructura real del JSON
  static void debugJson(Map<String, dynamic> json) {
    print('=== DEBUG JSON STRUCTURE ===');
    json.forEach((key, value) {
      print('$key: ${value.runtimeType} = $value');
    });
    print('=== END DEBUG ===');
  }
}
