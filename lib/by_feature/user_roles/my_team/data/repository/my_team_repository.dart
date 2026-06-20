import 'package:menu_dart_api/by_feature/user_roles/my_team/model/my_team_response.dart';

abstract class MyTeamRepository {
  Future<MyTeamResponse> getMyTeam();
}
