import 'package:menu_dart_api/by_feature/user_roles/revoke_role/model/revoke_role_request.dart';

abstract class RevokeRoleRepository {
  Future<void> revokeRole(RevokeRoleRequest request);
}
