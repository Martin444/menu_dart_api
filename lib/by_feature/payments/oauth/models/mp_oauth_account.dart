class MPOAuthAccount {
  final String id;
  final String collectorId;
  final String email;
  final String nickname;
  final String country;
  final String status;
  final DateTime createdAt;

  MPOAuthAccount({
    required this.id,
    required this.collectorId,
    required this.email,
    required this.nickname,
    required this.country,
    required this.status,
    required this.createdAt,
  });

  factory MPOAuthAccount.fromJson(Map<String, dynamic> json) {
    return MPOAuthAccount(
      id: json['id'],
      collectorId: json['collectorId'],
      email: json['email'],
      nickname: json['nickname'],
      country: json['country'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collectorId': collectorId,
      'email': email,
      'nickname': nickname,
      'country': country,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
