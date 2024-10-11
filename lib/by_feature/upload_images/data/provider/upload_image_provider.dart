import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:menu_dart_api/by_feature/upload_images/data/repository/upload_file_repository.dart';
import 'package:menu_dart_api/core/api.dart';

class UploadFileProvider extends UploadFileRepository {
  @override
  Future<String> uploadFile(image) async {
    try {
      Uri uploadURl = Uri.parse('${API.defaulBaseUrl}/cloudinary/upload');
      var responseUp = await dio.Dio().post(
        uploadURl.toString(),
        data: dio.FormData.fromMap(
          {
            'file': dio.MultipartFile.fromBytes(
              image,
              filename: 'plato${DateTime.now().toIso8601String()}',
            ),
          },
        ),
        options: dio.Options(
          headers: {
            'Content-Type': 'multipart/form-data', // Especifica el tipo de contenido
          },
        ),
      );

      var respoJson = jsonDecode(responseUp.toString());

      return respoJson['body'].toString();
    } catch (e) {
      rethrow;
    }
  }
}
