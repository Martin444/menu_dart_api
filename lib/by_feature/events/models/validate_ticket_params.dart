import 'package:menu_dart_api/by_feature/events/models/validatable_params.dart';

/// Parameters for validating a ticket manually.
class ValidateTicketParams with ValidatableParams {
  /// QR code to validate (required).
  final String qrCode;

  /// Validation mode: 'online' or 'offline' (default: 'online').
  final String mode;

  ValidateTicketParams({
    required this.qrCode,
    this.mode = 'online',
  });

  /// Validates all parameters.
  @override
  void validate() {
    validateRequiredString(qrCode, 'qrCode');

    final validModes = ['online', 'offline'];
    if (!validModes.contains(mode)) {
      throw ValidationException(
        'mode must be one of: ${validModes.join(", ")}',
        field: 'mode',
      );
    }
  }

  /// Converts parameters to JSON.
  Map<String, dynamic> toJson() {
    return {
      'qrCode': qrCode,
      'mode': mode,
    };
  }

  @override
  String toString() {
    return 'ValidateTicketParams(qrCode: ${qrCode.substring(0, qrCode.length > 20 ? 20 : qrCode.length)}..., mode: $mode)';
  }
}
