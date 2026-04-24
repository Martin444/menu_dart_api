import 'package:menu_dart_api/by_feature/user/count_users_admin/data/provider/count_users_admin_provider.dart';
import 'package:menu_dart_api/by_feature/user/count_users_admin/model/count_users_admin_params.dart';
import 'package:menu_dart_api/by_feature/user/count_users_admin/model/count_users_admin_response.dart';

class CountUsersAdminUseCase {
  final CountUsersAdminProvider _provider;

  CountUsersAdminUseCase({CountUsersAdminProvider? provider})
      : _provider = provider ?? CountUsersAdminProvider();

  Future<CountUsersAdminResponse> call(CountUsersAdminParams params) {
    return _provider.countUsersAdmin(params);
  }
}