import 'dart:convert';

import 'package:menu_dart_api/by_feature/events/data/repository/ticket_type_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/ticket_type_model.dart';
import 'package:menu_dart_api/by_feature/events/models/create_ticket_type_params.dart';
import 'package:menu_dart_api/by_feature/events/models/update_ticket_type_params.dart';
import 'package:menu_dart_api/core/api.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class TicketTypeProvider extends TicketTypeRepository {
  @override
  Future<TicketTypeModel> create(CreateTicketTypeParams params) async {
    try {
      final url = Uri.parse('${API.defaulBaseUrl}/ticket-types');
      final response = await API.httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
        body: jsonEncode(params.toJson()),
      );
      if (response.statusCode != 201 && response.statusCode != 200) {
        throw ApiException(response.statusCode, response.body);
      }
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      if (!json.containsKey('eventId') && !json.containsKey('event')) {
        json['eventId'] = params.eventId;
      }
      return TicketTypeModel.fromJson(json);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }

  @override
  Future<List<TicketTypeModel>> listByEvent(String eventId) async {
    try {
      final url =
          Uri.parse('${API.defaulBaseUrl}/ticket-types/event/$eventId');
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
      return data.map((e) {
        final json = e as Map<String, dynamic>;
        if (!json.containsKey('eventId') && !json.containsKey('event')) {
          json['eventId'] = eventId;
        }
        return TicketTypeModel.fromJson(json);
      }).toList();
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }

  @override
  Future<TicketTypeModel> update(UpdateTicketTypeParams params) async {
    try {
      final url =
          Uri.parse('${API.defaulBaseUrl}/ticket-types/${params.ticketTypeId}');
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
      return TicketTypeModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(500, e.toString());
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      final url = Uri.parse('${API.defaulBaseUrl}/ticket-types/$id');
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
