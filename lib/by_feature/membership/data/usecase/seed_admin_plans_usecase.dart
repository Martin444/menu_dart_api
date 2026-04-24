import 'package:menu_dart_api/by_feature/membership/data/repository/membership_repository.dart';

/// Caso de uso para sembrar planes estándar (admin)
class SeedAdminPlansUseCase {
  final MembershipRepository _repository;

  SeedAdminPlansUseCase(this._repository);

  Future<bool> call() async {
    return await _repository.seedStandardPlans();
  }
}
