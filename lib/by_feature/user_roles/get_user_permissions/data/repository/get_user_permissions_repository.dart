import 'package:menu_dart_api/by_feature/user_roles/models/user_permissions_response.dart';

abstract class GetUserPermissionsRepository {
  Future<UserPermissionsResponse> getUserPermissions(String userId, String context);
}
