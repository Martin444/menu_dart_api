import 'package:menu_dart_api/by_feature/membership/data/provider/membership_provider.dart';
import 'package:menu_dart_api/by_feature/membership/models/payment_link_model.dart';
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

class GeneratePaymentLinkUseCase {
  final MembershipProvider _provider;

  GeneratePaymentLinkUseCase(this._provider);

  Future<PaymentLinkModel> execute({
    required String userId,
    required String plan,
    required double amount,
    int periodMonths = 1,
    String? description,
  }) async {
    if (userId.isEmpty) {
      throw ApiException(400, 'El userId es requerido');
    }
    if (plan.isEmpty) {
      throw ApiException(400, 'El plan es requerido');
    }
    if (amount < 0) {
      throw ApiException(400, 'El monto no puede ser negativo');
    }

    return _provider.generatePaymentLink(
      userId: userId,
      plan: plan,
      amount: amount,
      periodMonths: periodMonths,
      description: description,
    );
  }
}