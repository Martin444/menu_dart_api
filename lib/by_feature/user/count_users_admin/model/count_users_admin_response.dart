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
    // Defensive parsing for 'count'
    int countValue = 0;
    if (json['count'] != null) {
      if (json['count'] is int) {
        countValue = json['count'] as int;
      } else if (json['count'] is Map) {
        // Defensive check for nested count (common in some aggregation responses)
        countValue = int.tryParse(json['count']['count']?.toString() ?? '0') ?? 0;
      } else {
        countValue = int.tryParse(json['count'].toString()) ?? 0;
      }
    } else if (json['total'] != null) {
      countValue = int.tryParse(json['total'].toString()) ?? 0;
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