import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/data/repository/membership_repository.dart';
import 'package:menu_dart_api/by_feature/membership/models/membership_plan_model.dart';

/// Caso de uso para actualizar un plan existente (admin)
class UpdateAdminPlanUseCase {
  final MembershipRepository _repository;

  UpdateAdminPlanUseCase({MembershipRepository? repository})
      : _repository = repository ?? MembershipProvider();

  Future<MembershipPlanModel> call(String id, Map<String, dynamic> planData) async {
    return await _repository.updatePlan(id, planData);
  }
}
