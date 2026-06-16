import 'package:menu_dart_api/by_feature/auth/models/role_type.dart';
import 'package:menu_dart_api/by_feature/auth/models/business_context.dart';

enum RolesUsers {
  clothes,
  dinning,
  customer,
  admin,
  retail,
  water_distributor,
  grocery,
  food,
  accessories,
  electronics,
  pharmacy,
  beauty,
  construction,
  automotive,
  pets,
  service,
  event_organizer,
}

class RolesFuncionts {
  static RolesUsers? getTypeRoleByRoleString(String role) {
    final normalizedRole = role.toLowerCase().trim();

    const backendToEnum = {
      'events': 'event_organizer',
    };

    final enumName = backendToEnum[normalizedRole] ?? normalizedRole;

    RolesUsers? roles;
    for (var value in RolesUsers.values) {
      if (value.toString().split('.').last == enumName) {
        roles = value;
      }
    }
    return roles;
  }

  static RoleType toRoleType(RolesUsers rolesUser) {
    switch (rolesUser) {
      case RolesUsers.customer:
        return RoleType.customer;
      case RolesUsers.admin:
        return RoleType.admin;
      case RolesUsers.event_organizer:
        return RoleType.eventOrganizer;
      case RolesUsers.clothes:
      case RolesUsers.dinning:
      case RolesUsers.food:
      case RolesUsers.retail:
      case RolesUsers.water_distributor:
      case RolesUsers.grocery:
      case RolesUsers.accessories:
      case RolesUsers.electronics:
      case RolesUsers.pets:
      case RolesUsers.pharmacy:
      case RolesUsers.beauty:
      case RolesUsers.construction:
      case RolesUsers.automotive:
      case RolesUsers.service:
        return RoleType.owner;
    }
  }

  static BusinessContext toBusinessContext(RolesUsers rolesUser) {
    switch (rolesUser) {
      case RolesUsers.clothes:
        return BusinessContext.wardrobe;
      case RolesUsers.dinning:
      case RolesUsers.food:
        return BusinessContext.restaurant;
      case RolesUsers.retail:
      case RolesUsers.water_distributor:
      case RolesUsers.grocery:
      case RolesUsers.accessories:
      case RolesUsers.electronics:
      case RolesUsers.pets:
        return BusinessContext.marketplace;
      case RolesUsers.event_organizer:
        return BusinessContext.events;
      case RolesUsers.customer:
      case RolesUsers.admin:
      case RolesUsers.pharmacy:
      case RolesUsers.beauty:
      case RolesUsers.construction:
      case RolesUsers.automotive:
      case RolesUsers.service:
        return BusinessContext.general;
    }
  }
}
