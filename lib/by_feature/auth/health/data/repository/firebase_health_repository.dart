import 'package:menu_dart_api/by_feature/auth/health/model/firebase_health_response.dart';

abstract class FirebaseHealthRepository {
  Future<FirebaseHealthResponse> checkHealth();
}
