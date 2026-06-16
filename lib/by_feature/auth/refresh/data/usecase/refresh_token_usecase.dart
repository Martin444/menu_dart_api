import 'package:menu_dart_api/by_feature/auth/refresh/data/provider/refresh_token_provider.dart';
import 'package:menu_dart_api/by_feature/auth/refresh/data/repository/refresh_token_repository.dart';
import 'package:menu_dart_api/by_feature/auth/refresh/model/refresh_token_response.dart';

class RefreshTokenUseCase {
  final RefreshTokenRepository _repository;

  RefreshTokenUseCase([RefreshTokenRepository? repository])
      : _repository = repository ?? RefreshTokenProvider();

  Future<RefreshTokenResponse> execute() async {
    return await _repository.refreshToken();
  }
}
