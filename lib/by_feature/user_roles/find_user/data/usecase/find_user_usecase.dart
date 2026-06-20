import 'package:menu_dart_api/by_feature/user_roles/find_user/data/provider/find_user_provider.dart';
import 'package:menu_dart_api/by_feature/user_roles/find_user/data/repository/find_user_repository.dart';
import 'package:menu_dart_api/by_feature/user_roles/find_user/model/find_user_response.dart';

class FindUserUseCase {
  final FindUserRepository _repository;

  FindUserUseCase([FindUserRepository? repository])
      : _repository = repository ?? FindUserProvider();

  Future<FindUserResponse> execute(String email) async {
    return await _repository.findUserByEmail(email);
  }
}
