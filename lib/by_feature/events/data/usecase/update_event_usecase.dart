import 'package:menu_dart_api/by_feature/events/data/repository/event_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/event_model.dart';
import 'package:menu_dart_api/by_feature/events/models/update_event_params.dart';

/// Use case for updating an existing event.
///
/// This use case updates event information with the provided parameters.
///
/// Example:
/// ```dart
/// final useCase = UpdateEventUseCase(repository);
/// final updated = await useCase.execute(UpdateEventParams(...));
/// ```
class UpdateEventUseCase {
  final EventRepository _repository;

  /// Creates a new instance of [UpdateEventUseCase].
  ///
  /// The [repository] parameter is required and must implement [EventRepository].
  const UpdateEventUseCase(this._repository);

  /// Executes the event update.
  ///
  /// [params] contains the event ID and fields to update.
  ///
  /// Returns the updated [EventModel].
  ///
  /// Throws [ApiException] if the event is not found or server error occurs.
  Future<EventModel> execute(UpdateEventParams params) async {
    return await _repository.update(params);
  }
}
