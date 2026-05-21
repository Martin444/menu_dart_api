import 'package:menu_dart_api/by_feature/events/data/repository/ticket_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/ticket_model.dart';

/// Use case for validating a ticket by its QR code.
///
/// This use case is used by event staff to validate tickets at entry.
/// It marks the ticket as used if valid.
///
/// Example:
/// ```dart
/// final useCase = ValidateQrCodeUseCase(repository);
/// final ticket = await useCase.execute('qr-code-data');
/// // Display ticket info and validation status
/// ```
class ValidateQrCodeUseCase {
  final TicketRepository _repository;

  /// Creates a new instance of [ValidateQrCodeUseCase].
  const ValidateQrCodeUseCase(this._repository);

  /// Executes the QR code validation.
  ///
  /// [code] is the scanned QR code content.
  ///
  /// Returns the validated [TicketModel].
  ///
  /// Throws [ApiException] if the code is invalid or ticket already used.
  Future<TicketModel> execute(String code) async {
    return await _repository.validateQrCode(code);
  }
}
