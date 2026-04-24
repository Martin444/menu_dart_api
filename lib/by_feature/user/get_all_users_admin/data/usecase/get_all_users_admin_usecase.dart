import 'package:menu_dart_api/by_feature/user/get_all_users_admin/data/provider/get_all_users_admin_provider.dart';
import 'package:menu_dart_api/by_feature/user/get_all_users_admin/model/get_all_users_admin_params.dart';
import 'package:menu_dart_api/by_feature/user/get_all_users_admin/model/get_all_users_admin_response.dart';

class GetAllUsersAdminUseCase {
  final GetAllUsersAdminProvider _provider;

  GetAllUsersAdminUseCase({GetAllUsersAdminProvider? provider})
      : _provider = provider ?? GetAllUsersAdminProvider();

  Future<GetAllUsersAdminResponse> call(GetAllUsersAdminParams params) {
    return _provider.getAllUsersAdmin(params);
  }
}