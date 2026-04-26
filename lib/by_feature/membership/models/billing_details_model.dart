/// Modelo para detalles de facturación de una membresía
class BillingDetailsModel {
  final String membershipId;
  final String userId;
  final BillingMode billingMode;
  final BillingPlanInfo currentPlan;
  final double effectivePrice;
  final double? adminSetPrice;
  final AutoBillingInfo? autoBilling;
  final ManualBillingInfo? manualBilling;
  final List<PaymentHistoryItem> paymentHistory;

  BillingDetailsModel({
    required this.membershipId,
    required this.userId,
    required this.billingMode,
    required this.currentPlan,
    required this.effectivePrice,
    this.adminSetPrice,
    this.autoBilling,
    this.manualBilling,
    this.paymentHistory = const [],
  });

  factory BillingDetailsModel.fromJson(Map<String, dynamic> json) {
    return BillingDetailsModel(
      membershipId: json['membershipId']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      billingMode: BillingMode.fromString(json['billingMode']?.toString() ?? 'none'),
      currentPlan: BillingPlanInfo.fromJson(json['currentPlan'] ?? {}),
      effectivePrice: double.tryParse(json['effectivePrice']?.toString() ?? '0') ?? 0.0,
      adminSetPrice: json['adminSetPrice'] != null
          ? double.tryParse(json['adminSetPrice'].toString())
          : null,
      autoBilling: json['autoBilling'] != null
          ? AutoBillingInfo.fromJson(json['autoBilling'])
          : null,
      manualBilling: json['manualBilling'] != null
          ? ManualBillingInfo.fromJson(json['manualBilling'])
          : null,
      paymentHistory: json['paymentHistory'] != null
          ? (json['paymentHistory'] as List)
              .map((e) => PaymentHistoryItem.fromJson(e))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'membershipId': membershipId,
      'userId': userId,
      'billingMode': billingMode.value,
      'currentPlan': currentPlan.toJson(),
      'effectivePrice': effectivePrice,
      'adminSetPrice': adminSetPrice,
      'autoBilling': autoBilling?.toJson(),
      'manualBilling': manualBilling?.toJson(),
      'paymentHistory': paymentHistory.map((e) => e.toJson()).toList(),
    };
  }
}

enum BillingMode {
  none('none'),
  manual('manual'),
  auto('auto');

  final String value;
  const BillingMode(this.value);

  static BillingMode fromString(String value) {
    return BillingMode.values.firstWhere(
      (e) => e.value == value,
      orElse: () => BillingMode.none,
    );
  }
}

class BillingPlanInfo {
  final String name;
  final String displayName;
  final double basePrice;

  BillingPlanInfo({
    required this.name,
    required this.displayName,
    required this.basePrice,
  });

  factory BillingPlanInfo.fromJson(Map<String, dynamic> json) {
    return BillingPlanInfo(
      name: json['name']?.toString() ?? '',
      displayName: json['displayName']?.toString() ?? '',
      basePrice: double.tryParse(json['basePrice']?.toString() ?? '0') ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'displayName': displayName,
      'basePrice': basePrice,
    };
  }
}

class AutoBillingInfo {
  final String? mpPreapprovalId;
  final String? status;
  final DateTime? nextBillingDate;
  final DateTime? lastPaymentAt;
  final String? paymentMethodId;

  AutoBillingInfo({
    this.mpPreapprovalId,
    this.status,
    this.nextBillingDate,
    this.lastPaymentAt,
    this.paymentMethodId,
  });

  factory AutoBillingInfo.fromJson(Map<String, dynamic> json) {
    return AutoBillingInfo(
      mpPreapprovalId: json['mpPreapprovalId']?.toString(),
      status: json['status']?.toString(),
      nextBillingDate: json['nextBillingDate'] != null
          ? DateTime.tryParse(json['nextBillingDate'].toString())
          : null,
      lastPaymentAt: json['lastPaymentAt'] != null
          ? DateTime.tryParse(json['lastPaymentAt'].toString())
          : null,
      paymentMethodId: json['paymentMethodId']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mpPreapprovalId': mpPreapprovalId,
      'status': status,
      'nextBillingDate': nextBillingDate?.toIso8601String(),
      'lastPaymentAt': lastPaymentAt?.toIso8601String(),
      'paymentMethodId': paymentMethodId,
    };
  }
}

class ManualBillingInfo {
  final String? pendingPaymentId;
  final String? pendingPaymentLink;
  final DateTime? pendingPaymentExpiresAt;

  ManualBillingInfo({
    this.pendingPaymentId,
    this.pendingPaymentLink,
    this.pendingPaymentExpiresAt,
  });

  factory ManualBillingInfo.fromJson(Map<String, dynamic> json) {
    return ManualBillingInfo(
      pendingPaymentId: json['pendingPaymentId']?.toString(),
      pendingPaymentLink: json['pendingPaymentLink']?.toString(),
      pendingPaymentExpiresAt: json['pendingPaymentExpiresAt'] != null
          ? DateTime.tryParse(json['pendingPaymentExpiresAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pendingPaymentId': pendingPaymentId,
      'pendingPaymentLink': pendingPaymentLink,
      'pendingPaymentExpiresAt': pendingPaymentExpiresAt?.toIso8601String(),
    };
  }
}

class PaymentHistoryItem {
  final String id;
  final DateTime date;
  final double amount;
  final String status;
  final String type;
  final int periodMonths;
  final bool isAdminGenerated;

  PaymentHistoryItem({
    required this.id,
    required this.date,
    required this.amount,
    required this.status,
    required this.type,
    required this.periodMonths,
    required this.isAdminGenerated,
  });

  factory PaymentHistoryItem.fromJson(Map<String, dynamic> json) {
    return PaymentHistoryItem(
      id: json['id']?.toString() ?? '',
      date: json['date'] != null
          ? DateTime.tryParse(json['date'].toString()) ?? DateTime.now()
          : DateTime.now(),
      amount: double.tryParse(json['amount']?.toString() ?? '0') ?? 0.0,
      status: json['status']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      periodMonths: json['periodMonths'] ?? 1,
      isAdminGenerated: json['isAdminGenerated'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'amount': amount,
      'status': status,
      'type': type,
      'periodMonths': periodMonths,
      'isAdminGenerated': isAdminGenerated,
    };
  }
}

/// Modelo para respuesta de habilitar auto-billing
class AutoBillingResponseModel {
  final String preapprovalId;
  final String status;
  final BillingMode billingMode;
  final DateTime? nextBillingDate;
  final AutoBillingMembershipData membership;

  AutoBillingResponseModel({
    required this.preapprovalId,
    required this.status,
    required this.billingMode,
    this.nextBillingDate,
    required this.membership,
  });

  factory AutoBillingResponseModel.fromJson(Map<String, dynamic> json) {
    return AutoBillingResponseModel(
      preapprovalId: json['preapprovalId']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      billingMode: BillingMode.fromString(json['billingMode']?.toString() ?? 'none'),
      nextBillingDate: json['nextBillingDate'] != null
          ? DateTime.tryParse(json['nextBillingDate'].toString())
          : null,
      membership: AutoBillingMembershipData.fromJson(json['membership'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'preapprovalId': preapprovalId,
      'status': status,
      'billingMode': billingMode.value,
      'nextBillingDate': nextBillingDate?.toIso8601String(),
      'membership': membership.toJson(),
    };
  }
}

class AutoBillingMembershipData {
  final String id;
  final String plan;
  final String? mpPreapprovalId;
  final String billingMode;
  final bool isActive;

  AutoBillingMembershipData({
    required this.id,
    required this.plan,
    this.mpPreapprovalId,
    required this.billingMode,
    required this.isActive,
  });

  factory AutoBillingMembershipData.fromJson(Map<String, dynamic> json) {
    return AutoBillingMembershipData(
      id: json['id']?.toString() ?? '',
      plan: json['plan']?.toString() ?? '',
      mpPreapprovalId: json['mpPreapprovalId']?.toString(),
      billingMode: json['billingMode']?.toString() ?? 'none',
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan': plan,
      'mpPreapprovalId': mpPreapprovalId,
      'billingMode': billingMode,
      'isActive': isActive,
    };
  }
}

/// Modelo para respuesta de cambio de monto
class ChangeAmountResponseModel {
  final String membershipId;
  final double previousAmount;
  final double newAmount;
  final DateTime effectiveFrom;
  final DateTime? nextBillingDate;

  ChangeAmountResponseModel({
    required this.membershipId,
    required this.previousAmount,
    required this.newAmount,
    required this.effectiveFrom,
    this.nextBillingDate,
  });

  factory ChangeAmountResponseModel.fromJson(Map<String, dynamic> json) {
    return ChangeAmountResponseModel(
      membershipId: json['membershipId']?.toString() ?? '',
      previousAmount: double.tryParse(json['previousAmount']?.toString() ?? '0') ?? 0.0,
      newAmount: double.tryParse(json['newAmount']?.toString() ?? '0') ?? 0.0,
      effectiveFrom: json['effectiveFrom'] != null
          ? DateTime.tryParse(json['effectiveFrom'].toString()) ?? DateTime.now()
          : DateTime.now(),
      nextBillingDate: json['nextBillingDate'] != null
          ? DateTime.tryParse(json['nextBillingDate'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'membershipId': membershipId,
      'previousAmount': previousAmount,
      'newAmount': newAmount,
      'effectiveFrom': effectiveFrom.toIso8601String(),
      'nextBillingDate': nextBillingDate?.toIso8601String(),
    };
  }
}