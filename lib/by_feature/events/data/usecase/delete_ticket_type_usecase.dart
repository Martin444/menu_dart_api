import 'package:menu_dart_api/by_feature/events/data/repository/ticket_type_repository.dart';

/// Use case for deleting a ticket type.
///
/// This use case removes a ticket type configuration.
/// Note: Should verify no tickets have been sold before deletion.
///
/// Example:
/// ```dart
/// final useCase = DeleteTicketTypeUseCase(repository);
/// await useCase.execute('tt-123');
/// ```
class DeleteTicketTypeUseCase {
  final TicketTypeRepository _repository;

  /// Creates a new instance of [DeleteTicketTypeUseCase].
  const DeleteTicketTypeUseCase(this._repository);

  /// Executes the ticket type deletion.
  ///
  /// [id] is the unique identifier of the ticket type.
  Future<void> execute(String id) async {
    return await _repository.delete(id);
  }
}
