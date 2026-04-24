import 'package:menu_dart_api/by_feature/user/update_user_admin/data/provider/update_user_admin_provider.dart';
import 'package:menu_dart_api/by_feature/user/update_user_admin/data/repository/update_user_admin_repository.dart';
import 'package:menu_dart_api/by_feature/user/update_user/model/update_user_request.dart';
import 'package:menu_dart_api/by_feature/user/update_user/model/update_user_response.dart';

class UpdateUserAdminUseCase {
  final UpdateUserAdminRepository _repository;

  UpdateUserAdminUseCase({UpdateUserAdminRepository? repository})
      : _repository = repository ?? UpdateUserAdminProvider();

  Future<UpdateUserResponse> call(UpdateUserRequest request) async {
    try {
      return await _repository.updateUserAdmin(request);
    } catch (e) {
      return UpdateUserResponse.error(
        'Error al actualizar usuario (admin): ${e.toString()}',
      );
    }
  }
}
