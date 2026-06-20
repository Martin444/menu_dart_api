class FindUserResponse {
  final String userId;
  final String name;
  final String email;

  FindUserResponse({
    required this.userId,
    required this.name,
    required this.email,
  });

  factory FindUserResponse.fromJson(Map<String, dynamic> json) {
    final outer = json['data'] as Map<String, dynamic>? ?? json;
    final data = outer['data'] as Map<String, dynamic>? ?? outer;
    return FindUserResponse(
      userId: data['userId'] as String? ?? '',
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
    );
  }
}
