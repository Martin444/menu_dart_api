class MPOAuthInitiateResponse {
  final String authorizationUrl;
  final String state;

  MPOAuthInitiateResponse({
    required this.authorizationUrl,
    required this.state,
  });

  factory MPOAuthInitiateResponse.fromJson(Map<String, dynamic> json) {
    return MPOAuthInitiateResponse(
      authorizationUrl: json['authorizationUrl'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authorizationUrl': authorizationUrl,
      'state': state,
    };
  }
}
