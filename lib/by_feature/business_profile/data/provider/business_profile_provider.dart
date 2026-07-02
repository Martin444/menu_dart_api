import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:menu_dart_api/by_feature/business_profile/data/repository/business_profile_repository.dart';
import 'package:menu_dart_api/by_feature/business_profile/models/business_profile_model.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class BusinessProfileProvider extends BusinessProfileRepository {
  dio.Dio get _dio => API.dioClient.dio;

  Map<String, dynamic> _unwrapData(dynamic rawData) {
    if (rawData is String) {
      rawData = jsonDecode(rawData);
    }
    if (rawData is Map<String, dynamic> && rawData.containsKey('data')) {
      return rawData['data'] as Map<String, dynamic>;
    }
    if (rawData is Map<String, dynamic>) {
      return rawData;
    }
    throw ApiException(500, 'Respuesta inválida del servidor');
  }

  @override
  Future<BusinessProfileModel> getProfile() async {
    try {
      final uri = Uri.parse('${API.defaulBaseUrl}/commerce/profile');

      final response = await _dio.get(
        uri.toString(),
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${API.loginAccessToken}',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      return BusinessProfileModel.fromJson(_unwrapData(response.data));
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ??
              e.message ??
              'Error al obtener perfil del comercio',
        );
      }
      rethrow;
    }
  }

  @override
  Future<BusinessProfileModel> updateProfile(
      Map<String, dynamic> updateData) async {
    try {
      final uri = Uri.parse('${API.defaulBaseUrl}/commerce/profile');

      final response = await _dio.patch(
        uri.toString(),
        data: updateData,
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${API.loginAccessToken}',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      return BusinessProfileModel.fromJson(_unwrapData(response.data));
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ??
              e.message ??
              'Error al actualizar perfil del comercio',
        );
      }
      rethrow;
    }
  }

  @override
  Future<BusinessProfileModel> getPublicProfile(String identifier) async {
    try {
      final uri =
          Uri.parse('${API.defaulBaseUrl}/public/commerce/$identifier/profile');

      final response = await _dio.get(
        uri.toString(),
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      return BusinessProfileModel.fromJson(_unwrapData(response.data));
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ??
              e.message ??
              'Error al obtener perfil público',
        );
      }
      rethrow;
    }
  }
}
