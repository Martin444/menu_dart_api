import 'package:menu_dart_api/by_feature/membership/data/repository/membership_repository.dart';

/// Caso de uso para archivar un plan (admin)
class ArchiveAdminPlanUseCase {
  final MembershipRepository _repository;

  ArchiveAdminPlanUseCase(this._repository);

  Future<bool> call(String id) async {
    return await _repository.archivePlan(id);
  }
}
