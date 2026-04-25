import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/data/repository/membership_repository.dart';

/// Caso de uso para obtener estadísticas de planes (admin)
class GetAdminPlanStatsUseCase {
  final MembershipRepository _repository;

  GetAdminPlanStatsUseCase({MembershipRepository? repository})
      : _repository = repository ?? MembershipProvider();

  Future<Map<String, dynamic>> call() async {
    return await _repository.getPlanStats();
  }
}
