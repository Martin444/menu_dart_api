import 'package:menu_dart_api/by_feature/user_roles/my_team/data/provider/my_team_provider.dart';
import 'package:menu_dart_api/by_feature/user_roles/my_team/data/repository/my_team_repository.dart';
import 'package:menu_dart_api/by_feature/user_roles/my_team/model/my_team_response.dart';

class GetMyTeamUseCase {
  final MyTeamRepository _repository;

  GetMyTeamUseCase([MyTeamRepository? repository])
      : _repository = repository ?? MyTeamProvider();

  Future<MyTeamResponse> execute() async {
    return await _repository.getMyTeam();
  }
}
