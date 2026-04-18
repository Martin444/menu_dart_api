/// Modelo que representa el estado de la membresía del usuario
class MembershipStatusModel {
  final bool isActive;
  final String? plan;
  final String? status;
  final double amount;
  final String currency;
  final double? originalPrice;
  final double? discountPercentage;
  final String? nextBillingDate;
  final String? lastPaymentAt;
  final String? paymentMethodId;
  final bool hasDiscount;
  final String? discountCode;
  final List<Map<String, dynamic>> billingHistory;

  MembershipStatusModel({
    required this.isActive,
    this.plan,
    this.status,
    this.amount = 0.0,
    this.currency = 'ARS',
    this.originalPrice,
    this.discountPercentage,
    this.nextBillingDate,
    this.lastPaymentAt,
    this.paymentMethodId,
    this.hasDiscount = false,
    this.discountCode,
    this.billingHistory = const [],
  });

  factory MembershipStatusModel.fromJson(Map<String, dynamic> json) {
    return MembershipStatusModel(
      isActive: json['isActive'] ?? false,
      plan: json['plan']?.toString(),
      status: json['status']?.toString(),
      amount: (json['amount'] ?? 0).toDouble(),
      currency: json['currency']?.toString() ?? 'ARS',
      originalPrice: json['originalPrice'] != null
          ? (json['originalPrice'] as num).toDouble()
          : null,
      discountPercentage: json['discountPercentage'] != null
          ? (json['discountPercentage'] as num).toDouble()
          : null,
      nextBillingDate: json['nextBillingDate']?.toString(),
      lastPaymentAt: json['lastPaymentAt']?.toString(),
      paymentMethodId: json['paymentMethodId']?.toString(),
      hasDiscount: json['hasDiscount'] ?? false,
      discountCode: json['discountCode']?.toString(),
      billingHistory: json['billingHistory'] != null
          ? (json['billingHistory'] as List).cast<Map<String, dynamic>>()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isActive': isActive,
      'plan': plan,
      'status': status,
      'amount': amount,
      'currency': currency,
      'originalPrice': originalPrice,
      'discountPercentage': discountPercentage,
      'nextBillingDate': nextBillingDate,
      'lastPaymentAt': lastPaymentAt,
      'paymentMethodId': paymentMethodId,
      'hasDiscount': hasDiscount,
      'discountCode': discountCode,
      'billingHistory': billingHistory,
    };
  }

  /// Estado inactivo por defecto (plan FREE)
  factory MembershipStatusModel.free() {
    return MembershipStatusModel(
      isActive: false,
      plan: 'FREE',
      status: 'inactive',
    );
  }
}
