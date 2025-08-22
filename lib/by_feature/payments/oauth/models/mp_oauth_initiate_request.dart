class MPOAuthInitiateRequest {
  final String redirectUri;
  final String? state;

  MPOAuthInitiateRequest({
    required this.redirectUri,
    this.state,
  });

  Map<String, dynamic> toJson() {
    return {
      'redirectUri': redirectUri,
      if (state != null) 'state': state,
    };
  }

  factory MPOAuthInitiateRequest.fromJson(Map<String, dynamic> json) {
    return MPOAuthInitiateRequest(
      redirectUri: json['redirectUri'],
      state: json['state'],
    );
  }
}
