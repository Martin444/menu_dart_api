import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/data/repository/membership_repository.dart';

/// Caso de uso para archivar/desactivar un plan (admin)
class ArchiveAdminPlanUseCase {
  final MembershipRepository _repository;

  ArchiveAdminPlanUseCase({MembershipRepository? repository})
      : _repository = repository ?? MembershipProvider();

  Future<bool> call(String id) async {
    return await _repository.archivePlan(id);
  }
}
