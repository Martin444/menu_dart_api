class SwitchContextRequest {
  final String commerceId;

  SwitchContextRequest({required this.commerceId});

  Map<String, dynamic> toJson() {
    return {'commerceId': commerceId};
  }
}

class SwitchContextResponse {
  final String accessToken;
  final String commerceId;
  final String? context;
  final List<Map<String, dynamic>> availableContexts;

  SwitchContextResponse({
    required this.accessToken,
    required this.commerceId,
    this.context,
    required this.availableContexts,
  });

  factory SwitchContextResponse.fromJson(Map<String, dynamic> json) {
    return SwitchContextResponse(
      accessToken: json['access_token'] as String? ?? '',
      commerceId: json['commerceId'] as String? ?? '',
      context: json['context'] as String?,
      availableContexts: (json['availableContexts'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'commerceId': commerceId,
      if (context != null) 'context': context,
      'availableContexts': availableContexts,
    };
  }
}
