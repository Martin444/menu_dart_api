/// Modelo que representa el resultado de aplicar un descuento
class DiscountResultModel {
  final bool valid;
  final String? message;
  final double? percentageOff;
  final double? amountOff;
  final double? finalPrice;

  DiscountResultModel({
    required this.valid,
    this.message,
    this.percentageOff,
    this.amountOff,
    this.finalPrice,
  });

  factory DiscountResultModel.fromJson(Map<String, dynamic> json) {
    final calculation = json['calculation'] as Map<String, dynamic>?;
    return DiscountResultModel(
      valid: json['valid'] ?? false,
      message: json['message']?.toString(),
      percentageOff: calculation != null
          ? double.tryParse(calculation['percentageOff'].toString())
          : null,
      amountOff: calculation != null
          ? double.tryParse(calculation['amountOff'].toString())
          : null,
      finalPrice: calculation != null
          ? double.tryParse(calculation['finalPrice'].toString())
          : null,
    );
  }
}
