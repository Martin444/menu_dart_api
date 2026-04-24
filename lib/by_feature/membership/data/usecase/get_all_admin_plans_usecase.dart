import 'package:menu_dart_api/by_feature/membership/data/repository/membership_repository.dart';
import 'package:menu_dart_api/by_feature/membership/models/membership_plan_model.dart';

/// Caso de uso para obtener todos los planes (admin)
class GetAllAdminPlansUseCase {
  final MembershipRepository _repository;

  GetAllAdminPlansUseCase(this._repository);

  Future<List<MembershipPlanModel>> call() async {
    return await _repository.getAllPlansAdmin();
  }
}
