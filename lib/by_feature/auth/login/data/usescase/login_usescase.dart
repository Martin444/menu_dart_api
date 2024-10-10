import 'package:menu_dart_api/by_feature/auth/login/data/provider/login_provider.dart';
import 'package:menu_dart_api/by_feature/auth/login/model/user_succes_model.dart';

class LoginUserUseCase {
  LoginUserUseCase();

  Future<UserSuccess> execute(
    String email,
    String password,
  ) async {
    try {
      var response = await LoginProvider().loginCommerce(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
