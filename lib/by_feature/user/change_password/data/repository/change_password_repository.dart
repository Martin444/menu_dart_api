import 'package:menu_dart_api/by_feature/user/change_password/model/change_password_params.dart';

abstract class ChangePasswordRepository {
  Future<dynamic> changePassword({
    required ChangePasswordParams params,
  });
}
