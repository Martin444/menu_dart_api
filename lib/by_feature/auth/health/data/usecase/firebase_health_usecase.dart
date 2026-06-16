import 'package:menu_dart_api/by_feature/auth/health/data/provider/firebase_health_provider.dart';
import 'package:menu_dart_api/by_feature/auth/health/data/repository/firebase_health_repository.dart';
import 'package:menu_dart_api/by_feature/auth/health/model/firebase_health_response.dart';

class FirebaseHealthUseCase {
  final FirebaseHealthRepository _repository;

  FirebaseHealthUseCase([FirebaseHealthRepository? repository])
      : _repository = repository ?? FirebaseHealthProvider();

  Future<FirebaseHealthResponse> execute() async {
    return await _repository.checkHealth();
  }
}
