import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class ManageUserSubscriptionUseCase {
  final MembershipProvider _provider;

  ManageUserSubscriptionUseCase(this._provider);

  Future<bool> pause(String membershipId) async {
    if (membershipId.isEmpty) {
      throw ApiException(400, 'El membershipId es requerido');
    }
    return _provider.pauseUserSubscription(membershipId);
  }

  Future<bool> resume(String membershipId) async {
    if (membershipId.isEmpty) {
      throw ApiException(400, 'El membershipId es requerido');
    }
    return _provider.resumeUserSubscription(membershipId);
  }

  Future<bool> extend({
    required String membershipId,
    required int periodMonths,
    String? reason,
  }) async {
    if (membershipId.isEmpty) {
      throw ApiException(400, 'El membershipId es requerido');
    }
    if (periodMonths <= 0) {
      throw ApiException(400, 'El período debe ser mayor a 0');
    }

    await _provider.extendMembership(
      membershipId: membershipId,
      periodMonths: periodMonths,
      reason: reason,
    );
    return true;
  }
}