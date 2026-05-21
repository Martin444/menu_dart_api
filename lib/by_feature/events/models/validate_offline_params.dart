import 'package:menu_dart_api/by_feature/events/models/validatable_params.dart';

/// Parameters for offline ticket validation.
class ValidateOfflineParams with ValidatableParams {
  /// Offline validation token (required).
  final String token;

  ValidateOfflineParams({
    required this.token,
  });

  /// Validates all parameters.
  @override
  void validate() {
    validateRequiredString(token, 'token');
  }

  /// Converts parameters to JSON.
  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }

  @override
  String toString() {
    return 'ValidateOfflineParams(token: ${token.substring(0, token.length > 20 ? 20 : token.length)}...)';
  }
}
