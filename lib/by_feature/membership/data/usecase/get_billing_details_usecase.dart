import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/models/billing_details_model.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class GetBillingDetailsUseCase {
  final MembershipProvider _provider;

  GetBillingDetailsUseCase(this._provider);

  Future<BillingDetailsModel> execute(String membershipId) async {
    if (membershipId.isEmpty) {
      throw ApiException(400, 'El membershipId es requerido');
    }

    return _provider.getBillingDetails(membershipId);
  }
}