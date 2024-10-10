import 'package:menu_dart_api/by_feature/auth/login/model/user_succes_model.dart';

abstract class RegisterCommerceRespository {
  Future<UserSuccess> registerCommerce({
    required String photo,
    required String email,
    required String name,
    required String phone,
    required String role,
    required String password,
  });
}
