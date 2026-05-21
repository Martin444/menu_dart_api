import 'package:menu_dart_api/by_feature/events/models/validatable_params.dart';

/// Parameters for checking a ticket's status.
class CheckTicketParams with ValidatableParams {
  /// QR code to check (required).
  final String qrCode;

  CheckTicketParams({
    required this.qrCode,
  });

  /// Validates all parameters.
  @override
  void validate() {
    validateRequiredString(qrCode, 'qrCode');
  }

  /// Converts parameters to JSON.
  Map<String, dynamic> toJson() {
    return {
      'qrCode': qrCode,
    };
  }

  @override
  String toString() {
    return 'CheckTicketParams(qrCode: ${qrCode.substring(0, qrCode.length > 20 ? 20 : qrCode.length)}...)';
  }
}
