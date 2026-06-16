class RefreshTokenResponse {
  final String accessToken;
  final Map<String, dynamic>? user;
  final String? commerceId;

  RefreshTokenResponse({
    required this.accessToken,
    this.user,
    this.commerceId,
  });

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      accessToken: json['access_token'] as String? ?? '',
      user: json['user'] as Map<String, dynamic>?,
      commerceId: json['commerceId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      if (user != null) 'user': user,
      if (commerceId != null) 'commerceId': commerceId,
    };
  }
}
