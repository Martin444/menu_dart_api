class MPOAuthInitiateResponse {
  final String authorizationUrl;
  final String state;
  final String? vinculationId;

  MPOAuthInitiateResponse({
    required this.authorizationUrl,
    required this.state,
    this.vinculationId,
  });

  factory MPOAuthInitiateResponse.fromJson(Map<String, dynamic> json) {
    return MPOAuthInitiateResponse(
      authorizationUrl: json['authorizationUrl'] ?? json['authorization_url'],
      state: json['state'],
      vinculationId: json['vinculation_id'] ?? json['vinculationId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authorizationUrl': authorizationUrl,
      'state': state,
      if (vinculationId != null) 'vinculation_id': vinculationId,
    };
  }
}
