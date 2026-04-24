import 'package:menu_dart_api/by_feature/user/get_all_users_admin/model/membership_enums.dart';

/// Filtros para la consulta de usuarios admin
class GetAllUsersAdminFilters {
  final MembershipPlanFilter? plan;
  final String? search;
  final String? createdAfter;
  final String? createdBefore;
  final bool? withActiveMembership;
  final bool? withVinculedAccount;
  final SortByField? sortBy;
  final SortOrder? sortOrder;
  final int? page;
  final int? limit;

  const GetAllUsersAdminFilters({
    this.plan,
    this.search,
    this.createdAfter,
    this.createdBefore,
    this.withActiveMembership,
    this.withVinculedAccount,
    this.sortBy,
    this.sortOrder,
    this.page,
    this.limit,
  });

  Map<String, dynamic> toQueryParams() {
    final params = <String, dynamic>{};
    
    if (plan != null) params['plan'] = plan!.value;
    if (search != null && search!.isNotEmpty) params['search'] = search;
    if (createdAfter != null) params['createdAfter'] = createdAfter;
    if (createdBefore != null) params['createdBefore'] = createdBefore;
    if (withActiveMembership == true) params['withActiveMembership'] = 'true';
    if (withVinculedAccount == true) params['withVinculedAccount'] = 'true';
    if (sortBy != null) params['sortBy'] = sortBy!.value;
    if (sortOrder != null) params['sortOrder'] = sortOrder!.value;
    if (page != null) params['page'] = page.toString();
    if (limit != null) params['limit'] = limit.toString();
    
    return params;
  }

  GetAllUsersAdminFilters copyWith({
    MembershipPlanFilter? plan,
    String? search,
    String? createdAfter,
    String? createdBefore,
    bool? withActiveMembership,
    bool? withVinculedAccount,
    SortByField? sortBy,
    SortOrder? sortOrder,
    int? page,
    int? limit,
  }) {
    return GetAllUsersAdminFilters(
      plan: plan ?? this.plan,
      search: search ?? this.search,
      createdAfter: createdAfter ?? this.createdAfter,
      createdBefore: createdBefore ?? this.createdBefore,
      withActiveMembership: withActiveMembership ?? this.withActiveMembership,
      withVinculedAccount: withVinculedAccount ?? this.withVinculedAccount,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }
}