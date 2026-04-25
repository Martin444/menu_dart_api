import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/data/repository/membership_repository.dart';
import 'package:menu_dart_api/by_feature/membership/models/payment_result_model.dart';

/// Caso de uso para crear un pago de membresía
class CreateMembershipPaymentUseCase {
  final MembershipRepository _repository;

  CreateMembershipPaymentUseCase({MembershipRepository? repository})
      : _repository = repository ?? MembershipProvider();

  Future<PaymentResultModel> call(String planId) async {
    return await _repository.createPayment(planId);
  }
}
