class PaymentStatusResponse {
  final String? id;
  final String? status;
  final String? statusDetail;
  final Map<String, dynamic>? raw;

  PaymentStatusResponse({this.id, this.status, this.statusDetail, this.raw});

  factory PaymentStatusResponse.fromJson(Map<String, dynamic> json) {
    return PaymentStatusResponse(
      id: json['id']?.toString(),
      status: json['status'] as String? ?? json['paymentStatus'] as String?,
      statusDetail: json['status_detail'] as String? ?? json['statusDetail'] as String?,
      raw: json,
    );
  }
}
