import 'package:menu_dart_api/by_feature/payments/data/provider/payments_provider.dart';
import 'package:menu_dart_api/by_feature/payments/data/repository/payments_repository.dart';
import 'package:menu_dart_api/by_feature/payments/models/payment_status_response.dart';

class GetPaymentStatusUseCase {
  final PaymentsRepository _repository;

  GetPaymentStatusUseCase([PaymentsRepository? repository])
      : _repository = repository ?? PaymentsProvider();

  Future<PaymentStatusResponse> execute(String paymentId) async {
    return await _repository.getPaymentStatus(paymentId);
  }
}

class CheckinPaymentUseCase {
  final PaymentsRepository _repository;

  CheckinPaymentUseCase([PaymentsRepository? repository])
      : _repository = repository ?? PaymentsProvider();

  Future<Map<String, dynamic>> execute(String paymentId) async {
    return await _repository.checkinPayment(paymentId);
  }
}
