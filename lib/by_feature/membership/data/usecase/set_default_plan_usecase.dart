import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/data/repository/membership_repository.dart';
import 'package:menu_dart_api/by_feature/membership/models/membership_plan_model.dart';

/// Caso de uso para establecer un plan como predeterminado
class SetDefaultPlanUseCase {
  final MembershipRepository _repository;

  SetDefaultPlanUseCase({MembershipRepository? repository}) : _repository = repository ?? MembershipProvider();

  /// Establece un plan como predeterminado para nuevos registros
  /// Solo puede haber un plan predeterminado a la vez
  Future<MembershipPlanModel> call(String planId) async {
    return await _repository.setDefaultPlan(planId);
  }
}
