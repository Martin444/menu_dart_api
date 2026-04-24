import 'package:menu_dart_api/by_feature/user/get_all_users_admin/model/get_all_users_admin_params.dart';
import 'package:menu_dart_api/by_feature/user/get_all_users_admin/model/get_all_users_admin_response.dart';

abstract class GetAllUsersAdminRepository {
  Future<GetAllUsersAdminResponse> getAllUsersAdmin(GetAllUsersAdminParams params);
}