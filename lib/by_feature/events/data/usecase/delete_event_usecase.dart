import 'package:menu_dart_api/by_feature/events/data/repository/event_repository.dart';

/// Use case for deleting an event.
///
/// This use case permanently removes an event from the system.
///
/// Example:
/// ```dart
/// final useCase = DeleteEventUseCase(repository);
/// await useCase.execute('event-123');
/// ```
class DeleteEventUseCase {
  final EventRepository _repository;

  /// Creates a new instance of [DeleteEventUseCase].
  ///
  /// The [repository] parameter is required and must implement [EventRepository].
  const DeleteEventUseCase(this._repository);

  /// Executes the event deletion.
  ///
  /// [id] is the unique identifier of the event to delete.
  ///
  /// Throws [ApiException] if the event is not found or server error occurs.
  Future<void> execute(String id) async {
    return await _repository.delete(id);
  }
}
