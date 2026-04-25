import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/data/repository/membership_repository.dart';
import 'package:menu_dart_api/by_feature/membership/models/membership_status_model.dart';

/// Caso de uso para obtener el estado de la membresía del usuario actual
class GetMembershipStatusUseCase {
  final MembershipRepository _repository;

  GetMembershipStatusUseCase({MembershipRepository? repository})
      : _repository = repository ?? MembershipProvider();

  Future<MembershipStatusModel> call() async {
    return await _repository.getMembershipStatus();
  }
}
