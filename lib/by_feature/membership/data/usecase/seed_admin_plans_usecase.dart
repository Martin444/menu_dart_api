import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/data/repository/membership_repository.dart';

/// Caso de uso para poblar planes por defecto
class SeedAdminPlansUseCase {
  final MembershipRepository _repository;

  SeedAdminPlansUseCase({MembershipRepository? repository})
      : _repository = repository ?? MembershipProvider();

  Future<bool> call() async {
    return await _repository.seedStandardPlans();
  }
}
