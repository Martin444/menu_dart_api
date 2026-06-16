import 'dart:convert';

import 'package:menu_dart_api/by_feature/auth/models/commerce_context.dart';
import 'package:menu_dart_api/by_feature/auth/my_contexts/data/repository/my_contexts_repository.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class MyContextsProvider extends MyContextsRepository {
  @override
  Future<List<CommerceContext>> getMyContexts() async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}/auth/my-contexts');
      final response = await API.httpClient.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
      );

      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorData['message'] ?? 'Error al obtener contextos',
        );
      }

      final responseData = jsonDecode(response.body);
      final List<dynamic> data = responseData is List
          ? responseData
          : (responseData['data'] as List<dynamic>? ?? []);

      return data
          .map((e) => CommerceContext.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
