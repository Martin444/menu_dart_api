class UpdateUserResponse {
  final bool success;
  final String message;
  final Map<String, dynamic>? userData;

  UpdateUserResponse({
    required this.success,
    required this.message,
    this.userData,
  });

  factory UpdateUserResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserResponse(
      success: json['success'] ?? true,
      message: json['message'] ?? 'Usuario actualizado exitosamente',
      userData: json['data'],
    );
  }

  factory UpdateUserResponse.error(String errorMessage) {
    return UpdateUserResponse(
      success: false,
      message: errorMessage,
    );
  }
}
