import 'dart:convert';
import 'dart:typed_data';

import 'package:menu_dart_api/by_feature/auth/register/data/repository/register_commerce_repository.dart';
import 'package:menu_dart_api/by_feature/auth/login/model/user_succes_model.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class RegisterCommerceProvider extends RegisterCommerceRepository {
  @override
  Future<UserSuccess> registerCommerce({
    Uint8List? fileBytes,
    required String email,
    required String name,
    required String phone,
    required String role,
    required String password,
  }) async {
    try {
      Uri loginURl = Uri.parse('${API.defaulBaseUrl}/auth/register');
      var request = http.MultipartRequest('POST', loginURl);

      if (fileBytes != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            fileBytes,
            filename: 'photo_${DateTime.now().millisecondsSinceEpoch}.jpg',
          ),
        );
      }

      request.fields['email'] = email;
      request.fields['name'] = name;
      request.fields['phone'] = phone;
      request.fields['password'] = password;
      request.fields['role'] = role;
      request.fields['needToChangepassword'] = 'false';

      var streamedResponse = await request.send();
      var login = await http.Response.fromStream(streamedResponse);

      var respJson = jsonDecode(login.body);
      final token = respJson['access_token'] ?? respJson['accessToken'];
      if (token == null) {
        throw ApiException(
          respJson['statusCode'] ?? 32,
          respJson['message']?.toString() ?? 'Error desconocido',
        );
      }
      return UserSuccess(
        accessToken: token,
        needToChangePassword: respJson['needToChangePassword'] ?? false,
        commerceId: respJson['commerceId'] as String?,
      );
    } catch (e) {
      rethrow;
    }
  }
}
