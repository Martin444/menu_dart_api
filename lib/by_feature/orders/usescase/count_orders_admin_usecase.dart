import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class CountOrdersAdminUseCase {
  CountOrdersAdminUseCase();

  Future<int> execute() async {
    try {
      Uri url = Uri.parse('${API.defaulBaseUrl}/orders/admin/count');

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

      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        return decoded['count'] as int? ?? decoded['total'] as int? ?? 0;
      }
      return decoded as int;
    } catch (e) {
      rethrow;
    }
  }
}
