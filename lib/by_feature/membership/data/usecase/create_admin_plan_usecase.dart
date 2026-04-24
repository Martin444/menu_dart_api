import 'package:menu_dart_api/by_feature/membership/data/repository/membership_repository.dart';
import 'package:menu_dart_api/by_feature/membership/models/membership_plan_model.dart';

/// Caso de uso para crear un nuevo plan (admin)
class CreateAdminPlanUseCase {
  final MembershipRepository _repository;

  CreateAdminPlanUseCase(this._repository);

  Future<MembershipPlanModel> call(Map<String, dynamic> planData) async {
    return await _repository.createPlan(planData);
  }
}
