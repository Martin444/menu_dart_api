import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class MigrateToManualBillingUseCase {
  final MembershipProvider _provider;

  MigrateToManualBillingUseCase(this._provider);

  Future<Map<String, dynamic>> execute(String membershipId) async {
    if (membershipId.isEmpty) {
      throw ApiException(400, 'El membershipId es requerido');
    }

    return _provider.migrateToManualBilling(membershipId);
  }
}