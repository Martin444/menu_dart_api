import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/data/repository/membership_repository.dart';
import 'package:menu_dart_api/by_feature/membership/models/membership_status_model.dart';

class AssignPlanToUserUseCase {
  final MembershipRepository _repository;

  AssignPlanToUserUseCase({MembershipRepository? repository})
      : _repository = repository ?? MembershipProvider();

  Future<MembershipStatusModel> call(String userId, String plan) {
    return _repository.assignPlanToUser(userId, plan);
  }
}
