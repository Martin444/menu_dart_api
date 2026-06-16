import 'package:menu_dart_api/by_feature/auth/models/user_role.dart';
import 'package:menu_dart_api/by_feature/user_roles/my_roles/data/provider/my_roles_provider.dart';
import 'package:menu_dart_api/by_feature/user_roles/my_roles/data/repository/my_roles_repository.dart';

class GetMyRolesUseCase {
  final MyRolesRepository _repository;

  GetMyRolesUseCase([MyRolesRepository? repository])
      : _repository = repository ?? MyRolesProvider();

  Future<List<UserRole>> execute({String? context, String? resourceId}) async {
    return await _repository.getMyRoles(context: context, resourceId: resourceId);
  }
}
