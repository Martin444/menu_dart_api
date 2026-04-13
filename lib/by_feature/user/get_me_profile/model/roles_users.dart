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
}

class RolesFuncionts {
  static RolesUsers? getTypeRoleByRoleString(String role) {
    RolesUsers? roles;
    for (var value in RolesUsers.values) {
      if (value.toString().split('.').last == role) {
        roles = value;
      }
    }
    return roles;
  }
}
