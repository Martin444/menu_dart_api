import 'package:menu_dart_api/by_feature/auth/models/user_role.dart';

abstract class MyRolesRepository {
  Future<List<UserRole>> getMyRoles({String? context, String? resourceId});
}
