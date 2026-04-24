import 'package:menu_dart_api/by_feature/membership/data/repository/membership_repository.dart';
import 'package:menu_dart_api/by_feature/membership/models/membership_plan_model.dart';

/// Caso de uso para obtener un plan por ID (admin)
class GetAdminPlanByIdUseCase {
  final MembershipRepository _repository;

  GetAdminPlanByIdUseCase(this._repository);

  Future<MembershipPlanModel> call(String id) async {
    return await _repository.getPlanByIdAdmin(id);
  }
}
