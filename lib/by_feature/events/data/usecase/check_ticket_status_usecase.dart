import 'package:menu_dart_api/by_feature/events/data/repository/ticket_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/check_ticket_params.dart';
import 'package:menu_dart_api/by_feature/events/models/ticket_status.dart';

/// Use case for checking a ticket's current status.
///
/// This use case verifies if a ticket is valid, used, or expired
/// without marking it as used. Useful for pre-validation checks.
///
/// Example:
/// ```dart
/// final useCase = CheckTicketStatusUseCase(repository);
/// final status = await useCase.execute(CheckTicketParams(
///   qrCode: 'qr-data',
/// ));
///
/// if (status.canBeUsed) {
///   print('Ticket is ready for entry');
/// } else if (status.isUsed) {
///   print('Already used at ${status.validatedAt}');
/// }
/// ```
class CheckTicketStatusUseCase {
  final TicketRepository _repository;

  /// Creates a new instance of [CheckTicketStatusUseCase].
  const CheckTicketStatusUseCase(this._repository);

  /// Executes the status check.
  ///
  /// [params] contains ticket identification data.
  ///
  /// Returns a [TicketStatus] with complete status information.
  Future<TicketStatus> execute(CheckTicketParams params) async {
    return await _repository.checkStatus(params);
  }
}
