import 'package:menu_dart_api/by_feature/user/delete_user/data/provider/delete_user_provider.dart';
import 'package:menu_dart_api/by_feature/user/delete_user/data/repository/delete_user_repository.dart';

class DeleteUserUseCase {
  final DeleteUserRepository _repository;

  DeleteUserUseCase({DeleteUserRepository? repository})
      : _repository = repository ?? DeleteUserProvider();

  Future<bool> call(String userId) {
    return _repository.deleteUser(userId);
  }
}
