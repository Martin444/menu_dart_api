/// Response model for MercadoPago checkout preference creation.
///
/// This model represents the response from creating a checkout preference,
/// which includes the payment URL to redirect the customer.
class CheckoutResponse {
  /// The MercadoPago preference ID.
  final String preferenceId;

  /// The URL to redirect the customer to complete payment.
  final String paymentUrl;

  /// The total amount to be charged.
  final double totalAmount;

  /// The currency code (e.g., 'ARS', 'USD').
  final String currency;

  /// When the preference expires.
  final DateTime? expirationDate;

  /// Additional metadata from the payment provider.
  final Map<String, dynamic>? metadata;

  const CheckoutResponse({
    required this.preferenceId,
    required this.paymentUrl,
    required this.totalAmount,
    this.currency = 'ARS',
    this.expirationDate,
    this.metadata,
  });

  /// Creates a [CheckoutResponse] from a JSON map.
  factory CheckoutResponse.fromJson(Map<String, dynamic> json) {
    return CheckoutResponse(
      preferenceId: json['preferenceId']?.toString() ??
          json['id']?.toString() ??
          '',
      paymentUrl: json['paymentUrl']?.toString() ??
          json['init_point']?.toString() ??
          '',
      totalAmount: _parseDouble(json['totalAmount']) ??
          _parseDouble(json['total_amount']) ??
          0.0,
      currency: json['currency']?.toString() ?? 'ARS',
      expirationDate: json['expirationDate'] != null
          ? DateTime.tryParse(json['expirationDate'].toString())
          : null,
      metadata: json['metadata'] is Map<String, dynamic>
          ? json['metadata'] as Map<String, dynamic>
          : null,
    );
  }

  /// Converts this response to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'preferenceId': preferenceId,
      'paymentUrl': paymentUrl,
      'totalAmount': totalAmount,
      'currency': currency,
      if (expirationDate != null)
        'expirationDate': expirationDate!.toIso8601String(),
      if (metadata != null) 'metadata': metadata,
    };
  }

  /// Helper method to safely parse double values.
  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString());
  }

  @override
  String toString() {
    return 'CheckoutResponse(preferenceId: $preferenceId, '
        'paymentUrl: $paymentUrl, totalAmount: $totalAmount)';
  }
}
