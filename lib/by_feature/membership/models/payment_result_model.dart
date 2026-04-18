/// Modelo que representa el resultado de crear un pago
class PaymentResultModel {
  final bool success;
  final String? paymentUrl;
  final String? initPoint;
  final String? message;

  PaymentResultModel({
    required this.success,
    this.paymentUrl,
    this.initPoint,
    this.message,
  });

  factory PaymentResultModel.fromJson(Map<String, dynamic> json) {
    return PaymentResultModel(
      success: true,
      paymentUrl: json['paymentUrl']?.toString(),
      initPoint: json['initPoint']?.toString(),
      message: json['message']?.toString(),
    );
  }

  /// Obtiene la URL a la que redirigir al usuario (paymentUrl o initPoint)
  String? get redirectUrl => paymentUrl ?? initPoint;
}
