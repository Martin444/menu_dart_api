import 'package:menu_dart_api/by_feature/events/models/event_model.dart';
import 'package:menu_dart_api/by_feature/events/models/create_event_params.dart';
import 'package:menu_dart_api/by_feature/events/models/update_event_params.dart';

abstract class EventRepository {
  Future<EventModel> create(CreateEventParams params);
  Future<List<EventModel>> list();
  Future<EventModel> getById(String id);
  Future<EventModel> update(UpdateEventParams params);
  Future<void> delete(String id);
}
