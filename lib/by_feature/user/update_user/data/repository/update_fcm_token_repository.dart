import 'package:menu_dart_api/by_feature/user/update_user/model/update_fcm_token_request.dart';

abstract class UpdateFcmTokenRepository {
  Future<void> updateFcmToken(UpdateFcmTokenRequest request);
}
