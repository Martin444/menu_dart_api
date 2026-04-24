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
    return CountUsersAdminResponse(
      count: json['count'] as int? ?? json as int? ?? 0,
      plan: json['plan'] as String?,
      withActiveMembership: json['withActiveMembership'] as bool?,
      withVinculedAccount: json['withVinculedAccount'] as bool?,
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