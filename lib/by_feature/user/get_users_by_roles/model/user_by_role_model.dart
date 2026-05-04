import 'package:flutter/foundation.dart';
import 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';

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
  final String? storeURL; // Nueva URL de la tienda
  final List<CatalogModel>? catalogs;

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
    this.storeURL,
    this.catalogs,
  });

  /// Crea una instancia desde un Map JSON
  factory UserByRoleModel.fromJson(Map<String, dynamic> json) {
    // Debuggea la estructura del JSON para identificar problemas
    return UserByRoleModel(
      id: _extractString(json['id']),
      photoURL: _extractString(json['photoURL']),
      name: _extractString(json['name']) ?? 'Sin nombre',
      email: _extractString(json['email']),
      phone: _extractString(json['phone']),
      needToChangepassword: _parseBool(json['needToChangepassword']),
      role: _extractString(json['role']),
      socialToken: _extractString(json['socialToken']),
      firebaseProvider: _extractString(json['firebaseProvider']),
      isEmailVerified: _parseBool(json['isEmailVerified']),
      lastLoginAt: _parseDateTime(json['lastLoginAt']),
      createAt: _parseDateTime(json['createAt']),
      updateAt: _parseDateTime(json['updateAt']),
      membership: json['membership'] as Map<String, dynamic>?,
      storeURL: _extractString(json['storeURL']),
      catalogs: _parseCatalogs(json['catalogs']),
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
      'storeURL': storeURL,
      'catalogs': catalogs?.map((catalog) => catalog.toJson()).toList(),
    };
  }

  /// Método auxiliar para parsear la lista de catálogos de forma segura
  static List<CatalogModel>? _parseCatalogs(dynamic value) {
    if (value == null) return null;
    if (value is! List) return null;

    try {
      return value
          .map((catalogJson) =>
              CatalogModel.fromJson(catalogJson as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error parsing catalogs: $value - $e');
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
        print('Error parsing date: $value - $e');
        return null;
      }
    }
    if (value is Map && value.containsKey('value')) {
      return _parseDateTime(value['value']);
    }
    return null;
  }

  /// Método auxiliar para parsear booleanos de forma segura
  static bool? _parseBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == 'true';
    if (value is Map && value.containsKey('value')) {
      return _parseBool(value['value']);
    }
    return null;
  }

  @override
  String toString() {
    return 'UserByRoleModel(id: $id, name: $name, email: $email, role: $role, isEmailVerified: $isEmailVerified, catalogsCount: ${catalogs?.length ?? 0})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserByRoleModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.role == role &&
        listEquals(other.catalogs, catalogs);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        role.hashCode ^
        (catalogs?.length.hashCode ?? 0);
  }
}
