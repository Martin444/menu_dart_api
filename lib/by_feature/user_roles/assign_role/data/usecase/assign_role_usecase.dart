import 'package:menu_dart_api/by_feature/user_roles/assign_role/data/provider/assign_role_provider.dart';
import 'package:menu_dart_api/by_feature/user_roles/assign_role/data/repository/assign_role_repository.dart';
import 'package:menu_dart_api/by_feature/user_roles/assign_role/model/assign_role.dart';

class AssignRoleUseCase {
  final AssignRoleRepository _repository;

  AssignRoleUseCase([AssignRoleRepository? repository])
      : _repository = repository ?? AssignRoleProvider();

  Future<AssignRoleResponse> execute(AssignRoleRequest request) async {
    return await _repository.assignRole(request);
  }
}
