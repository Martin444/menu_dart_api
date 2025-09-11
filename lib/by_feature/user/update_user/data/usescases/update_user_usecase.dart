import 'package:menu_dart_api/by_feature/user/update_user/data/provider/update_user_provider.dart';
import 'package:menu_dart_api/by_feature/user/update_user/model/update_user_request.dart';
import 'package:menu_dart_api/by_feature/user/update_user/model/update_user_response.dart';

class UpdateUserUseCase {
  final UpdateUserProvider _provider = UpdateUserProvider();

  Future<UpdateUserResponse> call(UpdateUserRequest request) async {
    try {
      return await _provider.updateUser(request);
    } catch (e) {
      return UpdateUserResponse.error(
        'Error al actualizar usuario: ${e.toString()}',
      );
    }
  }
}
