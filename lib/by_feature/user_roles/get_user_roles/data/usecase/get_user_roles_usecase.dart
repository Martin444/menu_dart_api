import 'package:menu_dart_api/by_feature/auth/models/user_role.dart';
import 'package:menu_dart_api/by_feature/user_roles/get_user_roles/data/provider/get_user_roles_provider.dart';
import 'package:menu_dart_api/by_feature/user_roles/get_user_roles/data/repository/get_user_roles_repository.dart';

class GetUserRolesUseCase {
  final GetUserRolesRepository _repository;

  GetUserRolesUseCase([GetUserRolesRepository? repository])
      : _repository = repository ?? GetUserRolesProvider();

  Future<List<UserRole>> execute(String userId, {String? context, String? resourceId}) async {
    return await _repository.getUserRoles(userId, context: context, resourceId: resourceId);
  }
}
