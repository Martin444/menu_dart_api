import 'package:menu_dart_api/by_feature/user/update_user_role/model/update_user_role_request.dart';
import 'package:menu_dart_api/by_feature/user/update_user_role/model/update_user_role_response.dart';

abstract class UpdateUserRoleRepository {
  Future<UpdateUserRoleResponse> updateMyRole(UpdateUserRoleRequest request);
}