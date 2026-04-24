import 'package:http/http.dart' as http;
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';
import 'package:menu_dart_api/by_feature/user/delete_user/data/repository/delete_user_repository.dart';

class DeleteUserProvider extends DeleteUserRepository {
  @override
  Future<bool> deleteUser(String userId) async {
    try {
      final url = Uri.parse('${API.defaulBaseUrl}/user/admin/$userId');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${API.loginAccessToken}',
      };

      final response = await http.delete(url, headers: headers);

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ApiException(
          response.statusCode,
          response.body,
        );
      }

      return true;
    } catch (e) {
      rethrow;
    }
  }
}
