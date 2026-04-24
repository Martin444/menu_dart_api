import 'package:menu_dart_api/by_feature/user/count_users_admin/model/count_users_admin_filters.dart';

/// Parámetros para contar usuarios (admin)
class CountUsersAdminParams {
  final CountUsersAdminFilters? filters;

  const CountUsersAdminParams({
    this.filters,
  });

  Map<String, dynamic> toQueryParams() {
    return filters?.toQueryParams() ?? {};
  }
}