import 'package:menu_dart_api/by_feature/auth/models/user_role.dart';
import 'package:menu_dart_api/by_feature/user_roles/update_role/model/update_role_request.dart';

abstract class UpdateRoleRepository {
  Future<UserRole> updateRole(String roleId, UpdateRoleRequest request);
}
