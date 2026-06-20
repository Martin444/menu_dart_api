import 'package:menu_dart_api/by_feature/user_roles/find_user/model/find_user_response.dart';

abstract class FindUserRepository {
  Future<FindUserResponse> findUserByEmail(String email);
}
