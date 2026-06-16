import 'package:menu_dart_api/by_feature/auth/models/commerce_context.dart';
import 'package:menu_dart_api/by_feature/auth/my_contexts/data/provider/my_contexts_provider.dart';
import 'package:menu_dart_api/by_feature/auth/my_contexts/data/repository/my_contexts_repository.dart';

class GetMyContextsUseCase {
  final MyContextsRepository _repository;

  GetMyContextsUseCase([MyContextsRepository? repository])
      : _repository = repository ?? MyContextsProvider();

  Future<List<CommerceContext>> execute() async {
    return await _repository.getMyContexts();
  }
}
