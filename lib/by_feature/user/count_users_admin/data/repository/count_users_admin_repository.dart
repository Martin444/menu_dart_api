import 'package:menu_dart_api/by_feature/user/count_users_admin/model/count_users_admin_params.dart';
import 'package:menu_dart_api/by_feature/user/count_users_admin/model/count_users_admin_response.dart';

abstract class CountUsersAdminRepository {
  Future<CountUsersAdminResponse> countUsersAdmin(CountUsersAdminParams params);
}