import 'package:menu_dart_api/by_feature/auth/login/model/user_succes_model.dart';
import 'package:menu_dart_api/by_feature/auth/register/data/provider/register_commerce_provider.dart';

class RegisterCommerceUsescase {
  RegisterCommerceUsescase();

  Future<UserSuccess> execute({
    required String photo,
    required String email,
    required String name,
    required String phone,
    required String role,
    required String password,
  }) async {
    try {
      var response = await RegisterCommerceProvider().registerCommerce(
        photo: photo,
        email: email,
        name: name,
        password: password,
        role: role,
        phone: phone,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
