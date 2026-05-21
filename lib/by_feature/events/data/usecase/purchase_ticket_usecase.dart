import 'package:menu_dart_api/by_feature/events/data/repository/ticket_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/ticket_model.dart';
import 'package:menu_dart_api/by_feature/events/models/purchase_ticket_params.dart';

/// Use case for purchasing a ticket.
///
/// This use case completes a ticket purchase after payment confirmation.
///
/// Example:
/// ```dart
/// final useCase = PurchaseTicketUseCase(repository);
/// final ticket = await useCase.execute(PurchaseTicketParams(
///   ticketTypeId: 'tt-123',
///   quantity: 2,
///   customerName: 'John Doe',
///   customerEmail: 'john@example.com',
/// ));
/// ```
class PurchaseTicketUseCase {
  final TicketRepository _repository;

  /// Creates a new instance of [PurchaseTicketUseCase].
  const PurchaseTicketUseCase(this._repository);

  /// Executes the ticket purchase.
  ///
  /// [params] contains purchase details including customer info.
  ///
  /// Returns the purchased [TicketModel] with QR code.
  Future<TicketModel> execute(PurchaseTicketParams params) async {
    return await _repository.purchase(params);
  }
}
