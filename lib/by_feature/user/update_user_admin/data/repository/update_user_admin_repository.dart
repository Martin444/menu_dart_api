import 'package:menu_dart_api/by_feature/user/update_user/model/update_user_request.dart';
import 'package:menu_dart_api/by_feature/user/update_user/model/update_user_response.dart';

abstract class UpdateUserAdminRepository {
  Future<UpdateUserResponse> updateUserAdmin(UpdateUserRequest request);
}
