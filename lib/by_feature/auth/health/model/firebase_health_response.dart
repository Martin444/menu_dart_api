class FirebaseHealthResponse {
  final String status;
  final Map<String, dynamic> firebase;

  FirebaseHealthResponse({
    required this.status,
    required this.firebase,
  });

  factory FirebaseHealthResponse.fromJson(Map<String, dynamic> json) {
    return FirebaseHealthResponse(
      status: json['status'] as String? ?? 'unknown',
      firebase: json['firebase'] as Map<String, dynamic>? ?? {},
    );
  }

  bool get isHealthy => status == 'healthy';
}
