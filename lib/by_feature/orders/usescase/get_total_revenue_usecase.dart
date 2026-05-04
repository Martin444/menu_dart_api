import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class GetTotalRevenueUseCase {
  GetTotalRevenueUseCase();

  Future<double> execute() async {
    try {
      Uri url = Uri.parse('${API.defaulBaseUrl}/orders/admin/revenue');

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
        final revenueStr = (decoded['revenue'] ?? decoded['total'] ?? '0').toString();
        return double.tryParse(revenueStr) ?? 0.0;
      }
      if (decoded is num) return decoded.toDouble();
      if (decoded is String) return double.tryParse(decoded) ?? 0.0;
      
      return 0.0;
    } catch (e) {
      rethrow;
    }
  }
}
