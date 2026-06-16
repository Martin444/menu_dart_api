import 'dart:convert';

import 'package:menu_dart_api/by_feature/auth/switch_context/data/repository/switch_context_repository.dart';
import 'package:menu_dart_api/by_feature/auth/switch_context/model/switch_context.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class SwitchContextProvider extends SwitchContextRepository {
  @override
  Future<SwitchContextResponse> switchContext(SwitchContextRequest request) async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}/auth/switch-context');
      final response = await API.httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        final errorData = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorData['message'] ?? 'Error al cambiar contexto',
        );
      }

      final responseData = jsonDecode(response.body);
      final contextResponse = SwitchContextResponse.fromJson(responseData);

      API.setAccessToken(contextResponse.accessToken);

      return contextResponse;
    } catch (e) {
      rethrow;
    }
  }
}
