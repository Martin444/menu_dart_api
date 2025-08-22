class MPOAuthCallbackRequest {
  final String authorizationCode;
  final String redirectUri;

  MPOAuthCallbackRequest({
    required this.authorizationCode,
    required this.redirectUri,
  });

  Map<String, dynamic> toJson() {
    return {
      'authorizationCode': authorizationCode,
      'redirectUri': redirectUri,
    };
  }

  factory MPOAuthCallbackRequest.fromJson(Map<String, dynamic> json) {
    return MPOAuthCallbackRequest(
      authorizationCode: json['authorizationCode'],
      redirectUri: json['redirectUri'],
    );
  }
}
