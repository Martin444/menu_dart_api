import 'package:menu_dart_api/by_feature/user_roles/revoke_role/data/provider/revoke_role_provider.dart';
import 'package:menu_dart_api/by_feature/user_roles/revoke_role/data/repository/revoke_role_repository.dart';
import 'package:menu_dart_api/by_feature/user_roles/revoke_role/model/revoke_role_request.dart';

class RevokeRoleUseCase {
  final RevokeRoleRepository _repository;

  RevokeRoleUseCase([RevokeRoleRepository? repository])
      : _repository = repository ?? RevokeRoleProvider();

  Future<void> execute(RevokeRoleRequest request) async {
    await _repository.revokeRole(request);
  }
}
