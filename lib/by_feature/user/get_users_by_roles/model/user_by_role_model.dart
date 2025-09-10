import 'package:flutter/foundation.dart';
import 'package:menu_dart_api/by_feature/menu/get_menu_bydinning/model/menu_model.dart';

/// Modelo que representa un usuario en la respuesta de usuarios por roles
///
/// Esta clase mapea la estructura completa del usuario retornada por la API
/// incluyendo información de autenticación, membresía, configuraciones y menús.
class UserByRoleModel {
  final String? id;
  final String? photoURL;
  final String? name;
  final String? email;
  final String? phone;
  final bool? needToChangepassword;
  final String? role;
  final String? socialToken;
  final String? firebaseProvider;
  final bool? isEmailVerified;
  final DateTime? lastLoginAt;
  final DateTime? createAt;
  final DateTime? updateAt;
  final Map<String, dynamic>? membership;
  final List<MenuModel>? menus;

  const UserByRoleModel({
    this.id,
    this.photoURL,
    this.name,
    this.email,
    this.phone,
    this.needToChangepassword,
    this.role,
    this.socialToken,
    this.firebaseProvider,
    this.isEmailVerified,
    this.lastLoginAt,
    this.createAt,
    this.updateAt,
    this.membership,
    this.menus,
  });

  /// Crea una instancia desde un Map JSON
  factory UserByRoleModel.fromJson(Map<String, dynamic> json) {
    // Debuggea la estructura del JSON para identificar problemas
    debugJson(json);

    return UserByRoleModel(
      id: _extractString(json['id']),
      photoURL: _extractString(json['photoURL']),
      name: _extractString(json['name']) ?? 'Sin nombre',
      email: _extractString(json['email']),
      phone: _extractString(json['phone']),
      needToChangepassword: json['needToChangepassword'] as bool?,
      role: _extractString(json['role']),
      socialToken: _extractString(json['socialToken']),
      firebaseProvider: _extractString(json['firebaseProvider']),
      isEmailVerified: json['isEmailVerified'] as bool?,
      lastLoginAt: _parseDateTime(json['lastLoginAt']),
      createAt: _parseDateTime(json['createAt']),
      updateAt: _parseDateTime(json['updateAt']),
      membership: json['membership'] as Map<String, dynamic>?,
      menus: _parseMenus(json['menus']),
    );
  }

  /// Convierte la instancia a un Map JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photoURL': photoURL,
      'name': name,
      'email': email,
      'phone': phone,
      'needToChangepassword': needToChangepassword,
      'role': role,
      'socialToken': socialToken,
      'firebaseProvider': firebaseProvider,
      'isEmailVerified': isEmailVerified,
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'createAt': createAt?.toIso8601String(),
      'updateAt': updateAt?.toIso8601String(),
      'membership': membership,
      'menus': menus
          ?.map((menu) => {
                'id': menu.id,
                'idOwner': menu.idOwner,
                'description': menu.description,
                'capacity': menu.capacity,
                'items': menu.items
                    ?.map((item) => {
                          'id': item.id,
                          'name': item.name,
                          'photoURL': item.photoUrl,
                          'price': item.price,
                          'ingredients': item.ingredients,
                          'deliveryTime': item.deliveryTime,
                        })
                    .toList(),
              })
          .toList(),
    };
  }

  /// Método auxiliar para parsear la lista de menús de forma segura
  static List<MenuModel>? _parseMenus(dynamic value) {
    if (value == null) return null;
    if (value is! List) return null;

    try {
      return value.map((menuJson) => MenuModel.fromJson(menuJson as Map<String, dynamic>)).toList();
    } catch (e) {
      debugPrint('Error parsing menus: $value - $e');
      return null;
    }
  }

  /// Método auxiliar para extraer strings de forma segura
  static String? _extractString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value.isEmpty ? null : value;
    if (value is Map && value.containsKey('value')) {
      return _extractString(value['value']);
    }
    // Si es un objeto, intenta convertirlo a string
    return value.toString();
  }

  /// Método auxiliar para parsear fechas de forma segura
  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        debugPrint('Error parsing date: $value - $e');
        return null;
      }
    }
    if (value is Map && value.containsKey('value')) {
      return _parseDateTime(value['value']);
    }
    return null;
  }

  /// Método para debugging - ayuda a ver la estructura real del JSON
  static void debugJson(Map<String, dynamic> json) {
    debugPrint('=== DEBUG JSON STRUCTURE ===');
    json.forEach((key, value) {
      debugPrint('$key: ${value.runtimeType} = $value');
    });
    debugPrint('=== END DEBUG ===');
  }

  @override
  String toString() {
    return 'UserByRoleModel(id: $id, name: $name, email: $email, role: $role, isEmailVerified: $isEmailVerified, menusCount: ${menus?.length ?? 0})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserByRoleModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.role == role &&
        listEquals(other.menus, menus);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode ^ role.hashCode ^ (menus?.length.hashCode ?? 0);
  }
}
