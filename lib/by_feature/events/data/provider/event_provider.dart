import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:menu_dart_api/by_feature/events/data/repository/event_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/event_model.dart';
import 'package:menu_dart_api/by_feature/events/models/create_event_params.dart';
import 'package:menu_dart_api/by_feature/events/models/update_event_params.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';
import 'package:menu_dart_api/core/helpers/multipart_helper.dart';

class EventProvider extends EventRepository {
  final dio.Dio _dio = dio.Dio();

  @override
  Future<EventModel> create(CreateEventParams params) async {
    try {
      final url = Uri.parse('${API.defaulBaseUrl}/events');

      // Build multipart form data
      final formDataMap = <String, dynamic>{};

      // Add text fields
      formDataMap['name'] = params.name.trim();
      formDataMap['startDate'] = params.startDate.toUtc().toIso8601String();
      formDataMap['endDate'] = params.endDate.toUtc().toIso8601String();
      formDataMap['venueId'] = params.venueId;
      if (params.description != null && params.description!.isNotEmpty) {
        formDataMap['description'] = params.description!.trim();
      }

      // Add image if exists
      if (params.image != null && params.image!.isNotEmpty) {
        formDataMap['image'] = dio.MultipartFile.fromBytes(
          params.image!,
          filename: MultipartHelper.generateFilename(
            prefix: 'event-banner',
            extension: 'jpg',
          ),
        );
      }

      final formData = dio.FormData.fromMap(formDataMap);

      final response = await _dio.post(
        url.toString(),
        data: formData,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer ${API.loginAccessToken}',
          },
        ),
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw ApiException(
          response.statusCode ?? 500,
          response.data.toString(),
        );
      }

      final responseData =
          response.data is String ? jsonDecode(response.data) : response.data;

      return EventModel.fromJson(responseData as Map<String, dynamic>);
    } catch (e) {
      if (e is dio.DioException) {
        throw ApiException(
          e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? e.message ?? 'Error al crear evento',
        );
      }
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }

  @override
  Future<List<EventModel>> list() async {
    try {
      final url = Uri.parse('${API.defaulBaseUrl}/events');
      final response = await API.httpClient.get(
        url,
        headers: {
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
      );
      if (response.statusCode != 200) {
        throw ApiException(response.statusCode, response.body);
      }
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }

  @override
  Future<EventModel> getById(String id) async {
    try {
      final url = Uri.parse('${API.defaulBaseUrl}/events/$id');
      final response = await API.httpClient.get(
        url,
        headers: {
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
      );
      if (response.statusCode != 200) {
        throw ApiException(response.statusCode, response.body);
      }
      return EventModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }

  @override
  Future<EventModel> update(UpdateEventParams params) async {
    try {
      final url = Uri.parse('${API.defaulBaseUrl}/events/${params.eventId}');
      final response = await API.httpClient.put(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
        body: jsonEncode(params.toJson()),
      );
      if (response.statusCode != 200) {
        throw ApiException(response.statusCode, response.body);
      }
      return EventModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      final url = Uri.parse('${API.defaulBaseUrl}/events/$id');
      final response = await API.httpClient.delete(
        url,
        headers: {
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
      );
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ApiException(response.statusCode, response.body);
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }
}
