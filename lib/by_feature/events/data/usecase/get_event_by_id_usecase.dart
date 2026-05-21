import 'package:menu_dart_api/by_feature/events/data/repository/event_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/event_model.dart';

/// Use case for retrieving a single event by its ID.
///
/// This use case fetches a specific event using its unique identifier.
///
/// Example:
/// ```dart
/// final useCase = GetEventByIdUseCase(repository);
/// final event = await useCase.execute('event-123');
/// ```
class GetEventByIdUseCase {
  final EventRepository _repository;

  /// Creates a new instance of [GetEventByIdUseCase].
  ///
  /// The [repository] parameter is required and must implement [EventRepository].
  const GetEventByIdUseCase(this._repository);

  /// Executes the event retrieval.
  ///
  /// [id] is the unique identifier of the event to retrieve.
  ///
  /// Returns the [EventModel] if found.
  ///
  /// Throws [ApiException] if the event is not found or server error occurs.
  Future<EventModel> execute(String id) async {
    return await _repository.getById(id);
  }
}
