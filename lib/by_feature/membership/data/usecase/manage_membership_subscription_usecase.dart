import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/data/repository/membership_repository.dart';

/// Caso de uso para gestionar suscripciones (pausar, reanudar, cancelar)
class ManageMembershipSubscriptionUseCase {
  final MembershipRepository _repository;

  ManageMembershipSubscriptionUseCase({MembershipRepository? repository})
      : _repository = repository ?? MembershipProvider();

  Future<bool> call(String action) async {
    switch (action) {
      case 'pause':
        return await _repository.pauseSubscription();
      case 'resume':
        return await _repository.resumeSubscription();
      case 'cancel':
        return await _repository.cancelSubscription();
      default:
        throw ArgumentError('Acción no válida: $action');
    }
  }
}
