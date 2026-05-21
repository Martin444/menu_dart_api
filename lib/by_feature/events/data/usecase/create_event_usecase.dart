import 'package:menu_dart_api/by_feature/events/data/repository/event_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/event_model.dart';
import 'package:menu_dart_api/by_feature/events/models/create_event_params.dart';

/// Use case for creating a new event.
///
/// This use case delegates the creation operation to the [EventRepository],
/// following the dependency inversion principle for better testability.
///
/// Example:
/// ```dart
/// final useCase = CreateEventUseCase(repository);
/// final event = await useCase.execute(CreateEventParams(...));
/// ```
class CreateEventUseCase {
  final EventRepository _repository;

  /// Creates a new instance of [CreateEventUseCase].
  ///
  /// The [repository] parameter is required and must implement [EventRepository].
  const CreateEventUseCase(this._repository);

  /// Executes the event creation.
  ///
  /// [params] contains all the required information to create the event.
  ///
  /// Returns the created [EventModel] with server-generated ID.
  ///
  /// Throws [ApiException] if the server returns an error.
  Future<EventModel> execute(CreateEventParams params) async {
    return await _repository.create(params);
  }
}
