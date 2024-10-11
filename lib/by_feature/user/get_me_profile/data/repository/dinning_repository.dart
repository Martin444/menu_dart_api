import 'package:menu_dart_api/by_feature/user/get_me_profile/model/dinning_model.dart';

abstract class DinningRepository {
  Future<DinningModel> getMe();
}
