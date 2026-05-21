import 'package:menu_dart_api/by_feature/events/models/ticket_type_model.dart';
import 'package:menu_dart_api/by_feature/events/models/create_ticket_type_params.dart';
import 'package:menu_dart_api/by_feature/events/models/update_ticket_type_params.dart';

abstract class TicketTypeRepository {
  Future<TicketTypeModel> create(CreateTicketTypeParams params);
  Future<List<TicketTypeModel>> listByEvent(String eventId);
  Future<TicketTypeModel> update(UpdateTicketTypeParams params);
  Future<void> delete(String id);
}
