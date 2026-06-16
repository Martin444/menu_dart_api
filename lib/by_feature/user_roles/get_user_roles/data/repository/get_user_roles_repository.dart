import 'package:menu_dart_api/by_feature/auth/models/user_role.dart';

abstract class GetUserRolesRepository {
  Future<List<UserRole>> getUserRoles(String userId, {String? context, String? resourceId});
}
