import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/data/repository/membership_repository.dart';
import 'package:menu_dart_api/by_feature/membership/models/membership_status_model.dart';

/// Caso de uso para cambiar de plan (upgrade/downgrade)
class UpgradeMembershipPlanUseCase {
  final MembershipRepository _repository;

  UpgradeMembershipPlanUseCase({MembershipRepository? repository})
      : _repository = repository ?? MembershipProvider();

  Future<MembershipStatusModel> call(String newPlanId) async {
    return await _repository.upgradePlan(newPlanId);
  }
}
