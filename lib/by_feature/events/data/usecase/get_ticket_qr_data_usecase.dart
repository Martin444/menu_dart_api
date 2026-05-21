import 'package:menu_dart_api/by_feature/events/data/repository/ticket_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/ticket_qr_data.dart';

/// Use case for retrieving QR code data for a ticket.
///
/// This use case fetches the QR code information for displaying
/// or sharing the ticket.
///
/// Example:
/// ```dart
/// final useCase = GetTicketQrDataUseCase(repository);
/// final data = await useCase.execute('ticket-123');
///
/// // Display QR code
/// QrImage(data: data.qrCode);
///
/// // Show event details
/// print('${data.eventName} - ${data.ticketTypeName}');
/// ```
class GetTicketQrDataUseCase {
  final TicketRepository _repository;

  /// Creates a new instance of [GetTicketQrDataUseCase].
  const GetTicketQrDataUseCase(this._repository);

  /// Executes the QR data retrieval.
  ///
  /// [ticketId] is the unique identifier of the ticket.
  ///
  /// Returns a [TicketQrData] with all QR and ticket information.
  Future<TicketQrData> execute(String ticketId) async {
    return await _repository.getQrData(ticketId);
  }
}
