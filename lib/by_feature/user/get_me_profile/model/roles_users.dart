enum RolesUsers {
  clothes,
  dinning,
  customer,
  admin,
  // Tipos de comercio del registro
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
  // Servicios profesionales
  service,
  // Organizador de eventos
  event_organizer,
}

class RolesFuncionts {
  static RolesUsers? getTypeRoleByRoleString(String role) {
    final normalizedRole = role.toLowerCase().trim();

    // Mapeo de códigos del backend a valores del enum
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
}
