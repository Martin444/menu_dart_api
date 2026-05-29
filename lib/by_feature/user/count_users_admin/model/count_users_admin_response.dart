/// Modelo que representa la respuesta de la API para contar usuarios (admin)
class CountUsersAdminResponse {
  final int count;
  final String? plan;
  final bool? withActiveMembership;
  final bool? withVinculedAccount;

  const CountUsersAdminResponse({
    required this.count,
    this.plan,
    this.withActiveMembership,
    this.withVinculedAccount,
  });

  factory CountUsersAdminResponse.fromJson(Map<String, dynamic> json) {
    // Handle wrapped response: { statusCode, message, data: { total } }
    final innerData = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    // Defensive parsing for 'count'
    int countValue = 0;
    if (innerData['count'] != null) {
      if (innerData['count'] is int) {
        countValue = innerData['count'] as int;
      } else if (innerData['count'] is Map) {
        countValue = int.tryParse(json['count']['count']?.toString() ?? '0') ?? 0;
      } else {
        countValue = int.tryParse(innerData['count'].toString()) ?? 0;
      }
    } else if (innerData['total'] != null) {
      countValue = int.tryParse(innerData['total'].toString()) ?? 0;
    }

    return CountUsersAdminResponse(
      count: countValue,
      plan: json['plan']?.toString(),
      withActiveMembership: json['withActiveMembership'] is bool ? json['withActiveMembership'] as bool : (json['withActiveMembership']?.toString().toLowerCase() == 'true'),
      withVinculedAccount: json['withVinculedAccount'] is bool ? json['withVinculedAccount'] as bool : (json['withVinculedAccount']?.toString().toLowerCase() == 'true'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      if (plan != null) 'plan': plan,
      if (withActiveMembership != null) 'withActiveMembership': withActiveMembership,
      if (withVinculedAccount != null) 'withVinculedAccount': withVinculedAccount,
    };
  }

  @override
  String toString() {
    return 'CountUsersAdminResponse(count: $count)';
  }
}