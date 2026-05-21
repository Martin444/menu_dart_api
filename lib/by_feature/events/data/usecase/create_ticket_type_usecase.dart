import 'package:menu_dart_api/by_feature/events/data/repository/ticket_type_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/ticket_type_model.dart';
import 'package:menu_dart_api/by_feature/events/models/create_ticket_type_params.dart';

/// Use case for creating a new ticket type for an event.
///
/// Ticket types define pricing, availability, and purchase limits for events.
///
/// Example:
/// ```dart
/// final useCase = CreateTicketTypeUseCase(repository);
/// final ticketType = await useCase.execute(CreateTicketTypeParams(
///   eventId: 'event-123',
///   name: 'General Admission',
///   price: 50.0,
///   totalQuantity: 100,
///   saleStartDate: DateTime.now(),
///   saleEndDate: DateTime.now().add(Duration(days: 30)),
///   maxPerUser: 5,
/// ));
/// ```
class CreateTicketTypeUseCase {
  final TicketTypeRepository _repository;

  /// Creates a new instance of [CreateTicketTypeUseCase].
  const CreateTicketTypeUseCase(this._repository);

  /// Executes the ticket type creation.
  ///
  /// [params] contains the ticket type configuration.
  ///
  /// Returns the created [TicketTypeModel].
  Future<TicketTypeModel> execute(CreateTicketTypeParams params) async {
    return await _repository.create(params);
  }
}
