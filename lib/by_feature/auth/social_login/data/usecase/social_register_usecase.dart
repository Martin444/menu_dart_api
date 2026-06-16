import 'package:menu_dart_api/by_feature/auth/social_login/data/provider/social_login_provider.dart';
import 'package:menu_dart_api/by_feature/auth/social_login/data/repository/social_login_repository.dart';
import 'package:menu_dart_api/by_feature/auth/social_login/model/social_login_response.dart';
import 'package:menu_dart_api/by_feature/auth/social_login/model/social_register_request.dart';

class SocialRegisterUseCase {
  final SocialLoginRepository _repository;

  SocialRegisterUseCase([SocialLoginRepository? repository])
      : _repository = repository ?? SocialLoginProvider();

  Future<SocialLoginResponse> execute({
    required String firebaseIdToken,
    required SocialRegisterRequest request,
  }) async {
    return await _repository.registerWithFirebaseToken(
      firebaseIdToken: firebaseIdToken,
      request: request,
    );
  }

  Future<SocialLoginResponse> executeWithGoogle({
    required String firebaseIdToken,
    required SocialRegisterRequest request,
  }) async {
    return execute(firebaseIdToken: firebaseIdToken, request: request);
  }

  Future<SocialLoginResponse> executeWithApple({
    required String firebaseIdToken,
    required SocialRegisterRequest request,
  }) async {
    return execute(firebaseIdToken: firebaseIdToken, request: request);
  }
}
