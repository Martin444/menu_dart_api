import 'package:menu_dart_api/by_feature/auth/switch_context/data/provider/switch_context_provider.dart';
import 'package:menu_dart_api/by_feature/auth/switch_context/data/repository/switch_context_repository.dart';
import 'package:menu_dart_api/by_feature/auth/switch_context/model/switch_context.dart';

class SwitchContextUseCase {
  final SwitchContextRepository _repository;

  SwitchContextUseCase([SwitchContextRepository? repository])
      : _repository = repository ?? SwitchContextProvider();

  Future<SwitchContextResponse> execute(SwitchContextRequest request) async {
    return await _repository.switchContext(request);
  }
}
