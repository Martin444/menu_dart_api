import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/data/repository/membership_repository.dart';
import 'package:menu_dart_api/by_feature/membership/models/membership_plan_model.dart';

/// Caso de uso para obtener los planes disponibles para el usuario
class GetMembershipPlansUseCase {
  final MembershipRepository _repository;

  GetMembershipPlansUseCase({MembershipRepository? repository})
      : _repository = repository ?? MembershipProvider();

  Future<List<MembershipPlanModel>> call() async {
    return await _repository.getAvailablePlans();
  }
}
