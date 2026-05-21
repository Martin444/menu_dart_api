import 'package:menu_dart_api/by_feature/events/data/repository/ticket_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/validate_offline_params.dart';
import 'package:menu_dart_api/by_feature/events/models/offline_validation_result.dart';

/// Use case for offline ticket validation.
///
/// This use case validates tickets without internet connection using
/// a pre-synchronized offline token. Useful for venues with poor connectivity.
///
/// Example:
/// ```dart
/// final useCase = ValidateOfflineTokenUseCase(repository);
/// final result = await useCase.execute(ValidateOfflineParams(
///   token: 'encrypted-token',
/// ));
///
/// if (result.isValid) {
///   print('Welcome ${result.customerName}!');
/// } else if (result.isAlreadyUsed) {
///   print('Ticket already used at ${result.validatedAt}');
/// }
/// ```
class ValidateOfflineTokenUseCase {
  final TicketRepository _repository;

  /// Creates a new instance of [ValidateOfflineTokenUseCase].
  const ValidateOfflineTokenUseCase(this._repository);

  /// Executes the offline validation.
  ///
  /// [params] contains offline validation data.
  ///
  /// Returns an [OfflineValidationResult] with validation details.
  Future<OfflineValidationResult> execute(ValidateOfflineParams params) async {
    return await _repository.validateOffline(params);
  }
}
