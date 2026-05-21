import 'package:menu_dart_api/by_feature/events/data/repository/ticket_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/ticket_model.dart';
import 'package:menu_dart_api/by_feature/events/models/validate_ticket_params.dart';

/// Use case for manually validating a ticket.
///
/// This use case provides manual validation with validation token,
/// useful as a fallback when QR scanning fails.
///
/// Example:
/// ```dart
/// final useCase = ValidateTicketUseCase(repository);
/// final ticket = await useCase.execute(ValidateTicketParams(
///   ticketId: 'ticket-123',
///   validationToken: 'token-xyz',
/// ));
/// ```
class ValidateTicketUseCase {
  final TicketRepository _repository;

  /// Creates a new instance of [ValidateTicketUseCase].
  const ValidateTicketUseCase(this._repository);

  /// Executes the manual ticket validation.
  ///
  /// [params] contains ticket ID and validation token.
  ///
  /// Returns the validated [TicketModel].
  Future<TicketModel> execute(ValidateTicketParams params) async {
    return await _repository.validateTicket(params);
  }
}
