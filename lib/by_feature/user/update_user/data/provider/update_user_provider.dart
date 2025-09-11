import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:menu_dart_api/by_feature/user/update_user/data/repository/update_user_repository.dart';
import 'package:menu_dart_api/by_feature/user/update_user/model/update_user_request.dart';
import 'package:menu_dart_api/by_feature/user/update_user/model/update_user_response.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class UpdateUserProvider extends UpdateUserRepository {
  @override
  Future<UpdateUserResponse> updateUser(UpdateUserRequest request) async {
    try {
      final String url = '${API.defaulBaseUrl}/user/update/${request.userId}';

      // Preparar FormData
      final formData = <String, dynamic>{};

      // Agregar campos de texto
      final textData = request.toFormData();
      formData.addAll(textData);

      // Agregar foto si existe
      if (request.hasPhoto) {
        formData['photo'] = dio.MultipartFile.fromBytes(
          request.photoBytes!,
          filename: request.photoFilename ?? 'user_photo_${DateTime.now().millisecondsSinceEpoch}.jpg',
        );
      }

      final dioFormData = dio.FormData.fromMap(formData);

      // Realizar la llamada PATCH con multipart/form-data
      final response = await dio.Dio().patch(
        url,
        data: dioFormData,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer ${API.loginAccessToken}',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Manejar respuesta exitosa
        final responseData = response.data is String ? jsonDecode(response.data) : response.data;

        return UpdateUserResponse.fromJson(responseData);
      } else {
        throw ApiException(
          response.statusCode ?? 500,
          response.data?.toString() ?? 'Error desconocido',
        );
      }
    } on dio.DioException catch (e) {
      String errorMessage = 'Error de conexión';

      if (e.response != null) {
        errorMessage = 'Error ${e.response?.statusCode}: ${e.response?.data}';
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? errorMessage,
        );
      } else {
        throw ApiException(500, errorMessage);
      }
    } catch (e) {
      throw ApiException(500, 'Error inesperado: ${e.toString()}');
    }
  }
}
