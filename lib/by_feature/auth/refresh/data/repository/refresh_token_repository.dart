import 'package:menu_dart_api/by_feature/auth/refresh/model/refresh_token_response.dart';

abstract class RefreshTokenRepository {
  Future<RefreshTokenResponse> refreshToken();
}
