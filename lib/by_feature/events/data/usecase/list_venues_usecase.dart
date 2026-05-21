import 'package:menu_dart_api/by_feature/events/data/repository/venue_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/venue_model.dart';

/// Use case for listing all venues.
///
/// This use case retrieves all available venues for hosting events.
///
/// Example:
/// ```dart
/// final useCase = ListVenuesUseCase(repository);
/// final venues = await useCase.execute();
/// ```
class ListVenuesUseCase {
  final VenueRepository _repository;

  /// Creates a new instance of [ListVenuesUseCase].
  const ListVenuesUseCase(this._repository);

  /// Executes the venues listing.
  ///
  /// Returns a list of [VenueModel] objects.
  Future<List<VenueModel>> execute() async {
    return await _repository.list();
  }
}
