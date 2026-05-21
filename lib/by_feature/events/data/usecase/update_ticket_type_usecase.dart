import 'package:menu_dart_api/by_feature/events/data/repository/ticket_type_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/ticket_type_model.dart';
import 'package:menu_dart_api/by_feature/events/models/update_ticket_type_params.dart';

/// Use case for updating an existing ticket type.
///
/// This use case allows modifying ticket type properties such as
/// price, quantity, and sale dates.
///
/// Example:
/// ```dart
/// final useCase = UpdateTicketTypeUseCase(repository);
/// final updated = await useCase.execute(UpdateTicketTypeParams(
///   ticketTypeId: 'tt-123',
///   price: 75.0,
/// ));
/// ```
class UpdateTicketTypeUseCase {
  final TicketTypeRepository _repository;

  /// Creates a new instance of [UpdateTicketTypeUseCase].
  const UpdateTicketTypeUseCase(this._repository);

  /// Executes the ticket type update.
  ///
  /// [params] contains the ticket type ID and fields to update.
  ///
  /// Returns the updated [TicketTypeModel].
  Future<TicketTypeModel> execute(UpdateTicketTypeParams params) async {
    return await _repository.update(params);
  }
}
