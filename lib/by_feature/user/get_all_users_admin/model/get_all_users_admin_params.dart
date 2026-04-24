import 'package:menu_dart_api/by_feature/user/get_all_users_admin/model/get_all_users_admin_filters.dart';

/// Parámetros para la consulta de todos los usuarios (admin)
class GetAllUsersAdminParams {
  final GetAllUsersAdminFilters? filters;

  const GetAllUsersAdminParams({
    this.filters,
  });

  Map<String, dynamic> toQueryParams() {
    return filters?.toQueryParams() ?? {};
  }

  GetAllUsersAdminParams copyWith({
    GetAllUsersAdminFilters? filters,
  }) {
    return GetAllUsersAdminParams(
      filters: filters ?? this.filters,
    );
  }
}