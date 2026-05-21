import 'package:menu_dart_api/by_feature/events/data/repository/ticket_repository.dart';
import 'package:menu_dart_api/by_feature/events/models/checkout_params.dart';
import 'package:menu_dart_api/by_feature/events/models/checkout_response.dart';

/// Use case for creating a MercadoPago checkout preference.
///
/// This use case creates a payment preference that returns a URL
/// to redirect the customer to MercadoPago checkout.
///
/// Example:
/// ```dart
/// final useCase = CreateCheckoutPreferenceUseCase(repository);
/// final response = await useCase.execute(CheckoutParams(
///   ticketTypeId: 'tt-123',
///   quantity: 2,
///   customerEmail: 'john@example.com',
/// ));
/// // response.paymentUrl contains the MercadoPago URL
/// // response.preferenceId for tracking
/// ```
class CreateCheckoutPreferenceUseCase {
  final TicketRepository _repository;

  /// Creates a new instance of [CreateCheckoutPreferenceUseCase].
  const CreateCheckoutPreferenceUseCase(this._repository);

  /// Executes the checkout preference creation.
  ///
  /// [params] contains the items to purchase.
  ///
  /// Returns a [CheckoutResponse] with preference details and payment URL.
  Future<CheckoutResponse> execute(CheckoutParams params) async {
    return await _repository.checkout(params);
  }
}
