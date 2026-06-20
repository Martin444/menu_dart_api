import 'dart:convert';

import 'package:menu_dart_api/by_feature/user_roles/my_team/data/repository/my_team_repository.dart';
import 'package:menu_dart_api/by_feature/user_roles/my_team/model/my_team_response.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class MyTeamProvider extends MyTeamRepository {
  @override
  Future<MyTeamResponse> getMyTeam() async {
    final Uri url = Uri.parse('${API.defaulBaseUrl}/user-roles/my-team');
    final response = await API.httpClient.get(
      url,
      headers: {
        'Authorization': 'Bearer ${API.loginAccessToken}',
      },
    );

    if (response.statusCode != 200) {
      final errorData = jsonDecode(response.body);
      throw ApiException(
        response.statusCode,
        errorData['message'] ?? 'Error al obtener equipo',
      );
    }

    return MyTeamResponse.fromJson(jsonDecode(response.body));
  }
}
