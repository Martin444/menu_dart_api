import 'package:menu_dart_api/by_feature/events/data/repository/venue_repository.dart';

/// Use case for deleting a venue.
///
/// This use case removes a venue from the system.
/// Note: Should verify no active events are using this venue before deletion.
///
/// Example:
/// ```dart
/// final useCase = DeleteVenueUseCase(repository);
/// await useCase.execute('venue-123');
/// ```
class DeleteVenueUseCase {
  final VenueRepository _repository;

  /// Creates a new instance of [DeleteVenueUseCase].
  const DeleteVenueUseCase(this._repository);

  /// Executes the venue deletion.
  ///
  /// [id] is the unique identifier of the venue to delete.
  Future<void> execute(String id) async {
    return await _repository.delete(id);
  }
}
