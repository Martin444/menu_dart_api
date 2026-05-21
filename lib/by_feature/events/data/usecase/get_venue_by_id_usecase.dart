import 'package:menu_dart_api/by_feature/events/data/repository/venue_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/venue_model.dart';

/// Use case for retrieving a venue by its ID.
///
/// This use case fetches a specific venue using its unique identifier.
///
/// Example:
/// ```dart
/// final useCase = GetVenueByIdUseCase(repository);
/// final venue = await useCase.execute('venue-123');
/// ```
class GetVenueByIdUseCase {
  final VenueRepository _repository;

  /// Creates a new instance of [GetVenueByIdUseCase].
  const GetVenueByIdUseCase(this._repository);

  /// Executes the venue retrieval.
  ///
  /// [id] is the unique identifier of the venue.
  ///
  /// Returns the [VenueModel] if found.
  Future<VenueModel> execute(String id) async {
    return await _repository.getById(id);
  }
}
