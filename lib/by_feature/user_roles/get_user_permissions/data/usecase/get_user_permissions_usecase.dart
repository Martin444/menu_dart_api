import 'package:menu_dart_api/by_feature/user_roles/get_user_permissions/data/provider/get_user_permissions_provider.dart';
import 'package:menu_dart_api/by_feature/user_roles/get_user_permissions/data/repository/get_user_permissions_repository.dart';
import 'package:menu_dart_api/by_feature/user_roles/models/user_permissions_response.dart';

class GetUserPermissionsUseCase {
  final GetUserPermissionsRepository _repository;

  GetUserPermissionsUseCase([GetUserPermissionsRepository? repository])
      : _repository = repository ?? GetUserPermissionsProvider();

  Future<UserPermissionsResponse> execute(String userId, String context) async {
    return await _repository.getUserPermissions(userId, context);
  }
}
