import 'package:menu_dart_api/by_feature/events/data/repository/event_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/event_model.dart';

/// Use case for listing all events.
///
/// This use case retrieves a list of all events from the repository.
///
/// Example:
/// ```dart
/// final useCase = ListEventsUseCase(repository);
/// final events = await useCase.execute();
/// ```
class ListEventsUseCase {
  final EventRepository _repository;

  /// Creates a new instance of [ListEventsUseCase].
  ///
  /// The [repository] parameter is required and must implement [EventRepository].
  const ListEventsUseCase(this._repository);

  /// Executes the events listing.
  ///
  /// Returns a list of [EventModel] objects.
  ///
  /// Throws [ApiException] if the server returns an error.
  Future<List<EventModel>> execute() async {
    return await _repository.list();
  }
}
