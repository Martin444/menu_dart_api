import 'dart:convert';

import 'package:menu_dart_api/by_feature/user/count_users_admin/data/repository/count_users_admin_repository.dart';
import 'package:menu_dart_api/by_feature/user/count_users_admin/model/count_users_admin_params.dart';
import 'package:menu_dart_api/by_feature/user/count_users_admin/model/count_users_admin_response.dart';
import 'package:http/http.dart' as http;
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class CountUsersAdminProvider extends CountUsersAdminRepository {
  @override
  Future<CountUsersAdminResponse> countUsersAdmin(CountUsersAdminParams params) async {
    try {
      final queryParams = params.toQueryParams();
      final queryString = queryParams.isNotEmpty 
          ? '?${_buildQueryString(queryParams)}' 
          : '';
      
      Uri url = Uri.parse('${API.defaulBaseUrl}/user/admin/count$queryString');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${API.loginAccessToken}',
      };

      var response = await http.get(url, headers: headers);

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode,
          response.body,
        );
      }

      var respJson = jsonDecode(response.body);
      return CountUsersAdminResponse.fromJson(respJson);
    } catch (e) {
      rethrow;
    }
  }

  String _buildQueryString(Map<String, dynamic> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');
  }
}