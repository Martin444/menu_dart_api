import 'package:menu_dart_api/by_feature/auth/models/user_role.dart';
import 'package:menu_dart_api/by_feature/user_roles/update_role/data/provider/update_role_provider.dart';
import 'package:menu_dart_api/by_feature/user_roles/update_role/data/repository/update_role_repository.dart';
import 'package:menu_dart_api/by_feature/user_roles/update_role/model/update_role_request.dart';

class UpdateRoleUseCase {
  final UpdateRoleRepository _repository;

  UpdateRoleUseCase([UpdateRoleRepository? repository])
      : _repository = repository ?? UpdateRoleProvider();

  Future<UserRole> execute(String roleId, UpdateRoleRequest request) async {
    return await _repository.updateRole(roleId, request);
  }
}
