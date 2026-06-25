import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:menu_dart_api/by_feature/notifications/data/repository/notification_repository.dart';
import 'package:menu_dart_api/by_feature/notifications/models/notification_template_model.dart';
import 'package:menu_dart_api/by_feature/notifications/models/paginated_templates_response.dart';
import 'package:menu_dart_api/by_feature/notifications/models/send_notification_result.dart';
import 'package:menu_dart_api/by_feature/notifications/models/user_with_fcm_token.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

/// Provider que implementa las operaciones de notificaciones admin contra la API.
///
/// Usa Dio (siguiendo el patrón de MembershipProvider) con el token JWT
/// inyectado automáticamente en cada request.
class NotificationProvider extends NotificationRepository {
  final dio.Dio _dio = dio.Dio();

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${API.loginAccessToken}',
      };

  dynamic _parseResponse(dio.Response response) {
    return response.data is String ? jsonDecode(response.data) : response.data;
  }

  /// Extrae el contenido del campo 'data' del envelope estándar de la API:
  /// {statusCode, message, data: <inner>}. Si no hay envelope, retorna el mapa original.
  Map<String, dynamic> _unwrapEnvelope(Map<String, dynamic> response) {
    if (response.containsKey('data') && response['data'] is Map) {
      return response['data'] as Map<String, dynamic>;
    }
    return response;
  }

  ApiException _toApiException(dio.DioException e, String fallback) {
    return ApiException(
      e.response?.statusCode ?? 500,
      e.response?.data?.toString() ?? e.message ?? fallback,
    );
  }

  @override
  Future<NotificationTemplateModel> createTemplate(CreateNotificationTemplateParams params) async {
    try {
      final response = await _dio.post(
        '${API.defaulBaseUrl}/notifications/admin/templates',
        data: jsonEncode(params.toJson()),
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return NotificationTemplateModel.fromJson(data);
    } on dio.DioException catch (e) {
      throw _toApiException(e, 'Error al crear template de notificación');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PaginatedTemplatesResponse> listTemplates(ListTemplatesParams params) async {
    try {
      final response = await _dio.get(
        '${API.defaulBaseUrl}/notifications/admin/templates',
        queryParameters: params.toQueryParams(),
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      // La respuesta del backend ya tiene { data: [...], meta: {...} }
      return PaginatedTemplatesResponse.fromJson(parsed);
    } on dio.DioException catch (e) {
      throw _toApiException(e, 'Error al listar templates de notificación');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<NotificationTemplateModel> getTemplate(String id) async {
    try {
      final response = await _dio.get(
        '${API.defaulBaseUrl}/notifications/admin/templates/$id',
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return NotificationTemplateModel.fromJson(data);
    } on dio.DioException catch (e) {
      throw _toApiException(e, 'Error al obtener template de notificación');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<NotificationTemplateModel> updateTemplate(String id, UpdateNotificationTemplateParams params) async {
    try {
      final response = await _dio.patch(
        '${API.defaulBaseUrl}/notifications/admin/templates/$id',
        data: jsonEncode(params.toJson()),
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return NotificationTemplateModel.fromJson(data);
    } on dio.DioException catch (e) {
      throw _toApiException(e, 'Error al actualizar template de notificación');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> deleteTemplate(String id) async {
    try {
      final response = await _dio.delete(
        '${API.defaulBaseUrl}/notifications/admin/templates/$id',
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response);
      if (parsed is Map<String, dynamic>) {
        return parsed;
      }
      return {'success': true, 'message': 'Template desactivado'};
    } on dio.DioException catch (e) {
      throw _toApiException(e, 'Error al desactivar template de notificación');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SendNotificationResult> sendDirectNotification(SendAdminNotificationParams params) async {
    try {
      final response = await _dio.post(
        '${API.defaulBaseUrl}/notifications/admin/send',
        data: jsonEncode(params.toJson()),
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 201) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return SendNotificationResult.fromJson(data);
    } on dio.DioException catch (e) {
      throw _toApiException(e, 'Error al enviar notificación directa');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SendFromTemplateResult> sendFromTemplate(String templateId, SendFromTemplateParams params) async {
    try {
      final response = await _dio.post(
        '${API.defaulBaseUrl}/notifications/admin/send-from-template/$templateId',
        data: jsonEncode(params.toJson()),
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return SendFromTemplateResult.fromJson(data);
    } on dio.DioException catch (e) {
      throw _toApiException(e, 'Error al enviar notificación desde template');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PaginatedUsersWithTokensResponse> getUsersWithTokens(ListUsersWithTokensParams params) async {
    try {
      final response = await _dio.get(
        '${API.defaulBaseUrl}/notifications/admin/users-with-tokens',
        queryParameters: params.toQueryParams(),
        options: dio.Options(headers: _headers),
      );

      if (response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final parsed = _parseResponse(response) as Map<String, dynamic>;
      final data = _unwrapEnvelope(parsed);
      return PaginatedUsersWithTokensResponse.fromJson(data);
    } on dio.DioException catch (e) {
      throw _toApiException(e, 'Error al listar usuarios con FCM token');
    } catch (e) {
      rethrow;
    }
  }
}
