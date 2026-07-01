import 'package:menu_dart_api/by_feature/business_profile/models/business_profile_model.dart';

abstract class BusinessProfileRepository {
  Future<BusinessProfileModel> getProfile();
  Future<BusinessProfileModel> updateProfile(
      Map<String, dynamic> updateData);
  Future<BusinessProfileModel> getPublicProfile(String identifier);
}
