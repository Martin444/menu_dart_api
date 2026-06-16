import 'package:menu_dart_api/by_feature/user_roles/assign_role/model/assign_role.dart';

abstract class AssignRoleRepository {
  Future<AssignRoleResponse> assignRole(AssignRoleRequest request);
}
