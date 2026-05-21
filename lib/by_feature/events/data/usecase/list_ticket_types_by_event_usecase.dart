import 'package:menu_dart_api/by_feature/events/data/repository/ticket_type_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/ticket_type_model.dart';

/// Use case for listing all ticket types for a specific event.
///
/// This use case retrieves all ticket types configured for an event,
/// including their pricing and availability information.
///
/// Example:
/// ```dart
/// final useCase = ListTicketTypesByEventUseCase(repository);
/// final ticketTypes = await useCase.execute('event-123');
/// ```
class ListTicketTypesByEventUseCase {
  final TicketTypeRepository _repository;

  /// Creates a new instance of [ListTicketTypesByEventUseCase].
  const ListTicketTypesByEventUseCase(this._repository);

  /// Executes the ticket types listing.
  ///
  /// [eventId] is the unique identifier of the event.
  ///
  /// Returns a list of [TicketTypeModel] objects for the event.
  Future<List<TicketTypeModel>> execute(String eventId) async {
    return await _repository.listByEvent(eventId);
  }
}
