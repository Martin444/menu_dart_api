import 'package:menu_dart_api/by_feature/events/data/repository/venue_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/venue_model.dart';
import 'package:menu_dart_api/by_feature/events/models/create_venue_params.dart';

/// Use case for creating a new venue.
///
/// This use case creates a venue location where events can be held.
///
/// Example:
/// ```dart
/// final useCase = CreateVenueUseCase(repository);
/// final venue = await useCase.execute(CreateVenueParams(...));
/// ```
class CreateVenueUseCase {
  final VenueRepository _repository;

  /// Creates a new instance of [CreateVenueUseCase].
  ///
  /// The [repository] parameter is required and must implement [VenueRepository].
  const CreateVenueUseCase(this._repository);

  /// Executes the venue creation.
  ///
  /// [params] contains the venue information.
  ///
  /// Returns the created [VenueModel].
  Future<VenueModel> execute(CreateVenueParams params) async {
    return await _repository.create(params);
  }
}
