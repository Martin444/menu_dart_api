import 'dart:convert';

import 'package:menu_dart_api/by_feature/auth/health/data/repository/firebase_health_repository.dart';
import 'package:menu_dart_api/by_feature/auth/health/model/firebase_health_response.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class FirebaseHealthProvider extends FirebaseHealthRepository {
  @override
  Future<FirebaseHealthResponse> checkHealth() async {
    try {
      final Uri url = Uri.parse('${API.defaulBaseUrl}/auth/firebase/health');
      final response = await API.httpClient.get(url);

      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.body);
        throw ApiException(
          response.statusCode,
          errorData['message'] ?? 'Error al verificar salud de Firebase',
        );
      }

      return FirebaseHealthResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
