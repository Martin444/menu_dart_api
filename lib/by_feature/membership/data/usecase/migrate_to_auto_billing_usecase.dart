import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/models/billing_details_model.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class MigrateToAutoBillingUseCase {
  final MembershipProvider _provider;

  MigrateToAutoBillingUseCase(this._provider);

  Future<AutoBillingResponseModel> execute({
    required String membershipId,
    required String cardTokenId,
    double? amount,
  }) async {
    if (membershipId.isEmpty) {
      throw ApiException(400, 'El membershipId es requerido');
    }
    if (cardTokenId.isEmpty) {
      throw ApiException(400, 'El cardTokenId es requerido');
    }

    return _provider.migrateToAutoBilling(
      membershipId: membershipId,
      cardTokenId: cardTokenId,
      amount: amount,
    );
  }
}