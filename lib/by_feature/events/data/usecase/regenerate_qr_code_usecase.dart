import 'package:menu_dart_api/by_feature/events/data/repository/ticket_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/ticket_model.dart';

/// Use case for regenerating a ticket's QR code.
///
/// This use case invalidates the old QR code and generates a new one.
/// Useful when a customer loses their ticket or for security reasons.
///
/// Example:
/// ```dart
/// final useCase = RegenerateQrCodeUseCase(repository);
/// final updatedTicket = await useCase.execute('ticket-123');
/// // updatedTicket.qrCode contains the new QR code
/// ```
class RegenerateQrCodeUseCase {
  final TicketRepository _repository;

  /// Creates a new instance of [RegenerateQrCodeUseCase].
  const RegenerateQrCodeUseCase(this._repository);

  /// Executes the QR code regeneration.
  ///
  /// [ticketId] is the unique identifier of the ticket.
  ///
  /// Returns the updated [TicketModel] with new QR code.
  Future<TicketModel> execute(String ticketId) async {
    return await _repository.regenerateQr(ticketId);
  }
}
