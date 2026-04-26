import 'package:menu_dart_api/by_feature/user/update_user_role/data/provider/update_user_role_provider.dart';
import 'package:menu_dart_api/by_feature/user/update_user_role/model/update_user_role_request.dart';
import 'package:menu_dart_api/by_feature/user/update_user_role/model/update_user_role_response.dart';

class UpdateUserRoleUseCase {
  final UpdateUserRoleProvider _provider = UpdateUserRoleProvider();

  Future<UpdateUserRoleResponse> call(UpdateUserRoleRequest request) async {
    try {
      return await _provider.updateMyRole(request);
    } catch (e) {
      return UpdateUserRoleResponse.error(
        'Error al actualizar rol: ${e.toString()}',
      );
    }
  }
}