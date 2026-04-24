import 'package:menu_dart_api/by_feature/user/get_all_users_admin/model/membership_enums.dart';

/// Filtros para contar usuarios (admin)
class CountUsersAdminFilters {
  final MembershipPlanFilter? plan;
  final bool? withActiveMembership;
  final bool? withVinculedAccount;

  const CountUsersAdminFilters({
    this.plan,
    this.withActiveMembership,
    this.withVinculedAccount,
  });

  Map<String, dynamic> toQueryParams() {
    final params = <String, dynamic>{};
    
    if (plan != null) params['plan'] = plan!.value;
    if (withActiveMembership == true) params['withActiveMembership'] = 'true';
    if (withVinculedAccount == true) params['withVinculedAccount'] = 'true';
    
    return params;
  }

  CountUsersAdminFilters copyWith({
    MembershipPlanFilter? plan,
    bool? withActiveMembership,
    bool? withVinculedAccount,
  }) {
    return CountUsersAdminFilters(
      plan: plan ?? this.plan,
      withActiveMembership: withActiveMembership ?? this.withActiveMembership,
      withVinculedAccount: withVinculedAccount ?? this.withVinculedAccount,
    );
  }
}