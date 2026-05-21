import 'package:menu_dart_api/by_feature/events/data/repository/ticket_repository.dart';

/// Use case for downloading a ticket PDF.
///
/// This use case retrieves the PDF representation of a ticket.
///
/// Example:
/// ```dart
/// final useCase = DownloadTicketPdfUseCase(repository);
/// final pdfBytes = await useCase.execute('ticket-123');
/// // Save or display the PDF
/// ```
class DownloadTicketPdfUseCase {
  final TicketRepository _repository;

  /// Creates a new instance of [DownloadTicketPdfUseCase].
  const DownloadTicketPdfUseCase(this._repository);

  /// Executes the PDF download.
  ///
  /// [ticketId] is the unique identifier of the ticket.
  ///
  /// Returns the PDF content as a String.
  ///
  /// TODO: Change return type from String to List<int> for proper binary handling.
  Future<String> execute(String ticketId) async {
    return await _repository.downloadPdf(ticketId);
  }
}
