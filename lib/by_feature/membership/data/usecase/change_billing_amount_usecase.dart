import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/models/billing_details_model.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class ChangeBillingAmountUseCase {
  final MembershipProvider _provider;

  ChangeBillingAmountUseCase(this._provider);

  Future<ChangeAmountResponseModel> execute({
    required String membershipId,
    required double newAmount,
    String? reason,
  }) async {
    if (membershipId.isEmpty) {
      throw ApiException(400, 'El membershipId es requerido');
    }
    if (newAmount < 0) {
      throw ApiException(400, 'El monto no puede ser negativo');
    }

    return _provider.changeBillingAmount(
      membershipId: membershipId,
      newAmount: newAmount,
      reason: reason,
    );
  }
}