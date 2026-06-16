import 'package:menu_dart_api/by_feature/user_roles/my_permissions/data/provider/my_permissions_provider.dart';
import 'package:menu_dart_api/by_feature/user_roles/my_permissions/data/repository/my_permissions_repository.dart';
import 'package:menu_dart_api/by_feature/user_roles/models/user_permissions_response.dart';

class GetMyPermissionsUseCase {
  final MyPermissionsRepository _repository;

  GetMyPermissionsUseCase([MyPermissionsRepository? repository])
      : _repository = repository ?? MyPermissionsProvider();

  Future<UserPermissionsResponse> execute(String context) async {
    return await _repository.getMyPermissions(context);
  }
}
