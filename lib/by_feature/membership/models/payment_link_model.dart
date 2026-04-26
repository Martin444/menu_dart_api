/// Modelo para el resultado de generar link de pago
class PaymentLinkModel {
  final String paymentId;
  final String paymentLink;
  final double amount;
  final String currency;
  final int periodMonths;
  final DateTime expiresAt;
  final String status;
  final PaymentLinkMembershipData membership;

  PaymentLinkModel({
    required this.paymentId,
    required this.paymentLink,
    required this.amount,
    required this.currency,
    required this.periodMonths,
    required this.expiresAt,
    required this.status,
    required this.membership,
  });

  factory PaymentLinkModel.fromJson(Map<String, dynamic> json) {
    return PaymentLinkModel(
      paymentId: json['paymentId']?.toString() ?? '',
      paymentLink: json['paymentLink']?.toString() ?? '',
      amount: double.tryParse(json['amount']?.toString() ?? '0') ?? 0.0,
      currency: json['currency']?.toString() ?? 'ARS',
      periodMonths: json['periodMonths'] ?? 1,
      expiresAt: json['expiresAt'] != null
          ? DateTime.tryParse(json['expiresAt'].toString()) ?? DateTime.now()
          : DateTime.now().add(const Duration(days: 30)),
      status: json['status']?.toString() ?? 'pending',
      membership: PaymentLinkMembershipData.fromJson(
        json['membership'] ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentId': paymentId,
      'paymentLink': paymentLink,
      'amount': amount,
      'currency': currency,
      'periodMonths': periodMonths,
      'expiresAt': expiresAt.toIso8601String(),
      'status': status,
      'membership': membership.toJson(),
    };
  }
}

class PaymentLinkMembershipData {
  final String id;
  final String plan;
  final String? pendingPaymentId;
  final String billingMode;

  PaymentLinkMembershipData({
    required this.id,
    required this.plan,
    this.pendingPaymentId,
    required this.billingMode,
  });

  factory PaymentLinkMembershipData.fromJson(Map<String, dynamic> json) {
    return PaymentLinkMembershipData(
      id: json['id']?.toString() ?? '',
      plan: json['plan']?.toString() ?? '',
      pendingPaymentId: json['pendingPaymentId']?.toString(),
      billingMode: json['billingMode']?.toString() ?? 'none',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan': plan,
      'pendingPaymentId': pendingPaymentId,
      'billingMode': billingMode,
    };
  }
}