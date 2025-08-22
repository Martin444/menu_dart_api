class MPOAuthBaseResponse {
  final bool success;
  final String? message;

  MPOAuthBaseResponse({
    required this.success,
    this.message,
  });

  factory MPOAuthBaseResponse.fromJson(Map<String, dynamic> json) {
    return MPOAuthBaseResponse(
      success: json['success'] ?? true,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      if (message != null) 'message': message,
    };
  }
}
