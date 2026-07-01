import 'package:menu_dart_api/by_feature/business_profile/data/provider/business_profile_provider.dart';
import 'package:menu_dart_api/by_feature/business_profile/data/repository/business_profile_repository.dart';
import 'package:menu_dart_api/by_feature/business_profile/models/business_profile_model.dart';

class GetBusinessProfileUseCase {
  final BusinessProfileRepository _repository;

  GetBusinessProfileUseCase([BusinessProfileRepository? repository])
      : _repository = repository ?? BusinessProfileProvider();

  Future<BusinessProfileModel> execute() async {
    return await _repository.getProfile();
  }
}

class UpdateBusinessProfileUseCase {
  final BusinessProfileRepository _repository;

  UpdateBusinessProfileUseCase([BusinessProfileRepository? repository])
      : _repository = repository ?? BusinessProfileProvider();

  Future<BusinessProfileModel> execute(
      Map<String, dynamic> updateData) async {
    return await _repository.updateProfile(updateData);
  }
}

class GetPublicBusinessProfileUseCase {
  final BusinessProfileRepository _repository;

  GetPublicBusinessProfileUseCase([BusinessProfileRepository? repository])
      : _repository = repository ?? BusinessProfileProvider();

  Future<BusinessProfileModel> execute(String identifier) async {
    return await _repository.getPublicProfile(identifier);
  }
}
