import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/models/billing_details_model.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class EnableAutoBillingUseCase {
  final MembershipProvider _provider;

  EnableAutoBillingUseCase(this._provider);

  Future<AutoBillingResponseModel> execute({
    required String userId,
    required String plan,
    required String cardTokenId,
    double? amount,
    String billingCycle = 'monthly',
  }) async {
    if (userId.isEmpty) {
      throw ApiException(400, 'El userId es requerido');
    }
    if (plan.isEmpty) {
      throw ApiException(400, 'El plan es requerido');
    }
    if (cardTokenId.isEmpty) {
      throw ApiException(400, 'El cardTokenId es requerido');
    }

    return _provider.enableAutoBilling(
      userId: userId,
      plan: plan,
      cardTokenId: cardTokenId,
      amount: amount,
      billingCycle: billingCycle,
    );
  }
}