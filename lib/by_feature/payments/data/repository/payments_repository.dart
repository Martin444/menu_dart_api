import 'package:menu_dart_api/by_feature/payments/models/payment_status_response.dart';

abstract class PaymentsRepository {
  Future<PaymentStatusResponse> getPaymentStatus(String paymentId);
  Future<Map<String, dynamic>> checkinPayment(String paymentId);
}
