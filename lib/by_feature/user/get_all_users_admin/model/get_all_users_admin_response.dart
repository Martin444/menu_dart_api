import 'package:menu_dart_api/by_feature/user/get_users_by_roles/model/user_by_role_model.dart';

/// Modelo que representa la respuesta de la API para obtener todos los usuarios (admin)
class GetAllUsersAdminResponse {
  final List<UserByRoleModel> users;
  final int total;
  final int page;
  final int limit;
  final int totalPages;
  final bool hasNext;
  final bool hasPrev;

  const GetAllUsersAdminResponse({
    required this.users,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrev,
  });

  factory GetAllUsersAdminResponse.fromJson(Map<String, dynamic> json) {
    final pagination = json['pagination'] is Map<String, dynamic> 
        ? json['pagination'] as Map<String, dynamic>
        : null;
    
    final usersData = json['data'] is List ? json['data'] as List : [];
    final totalCount = json['total'] as int? ?? pagination?['total'] as int? ?? 0;
    final currentPage = json['page'] as int? ?? pagination?['page'] as int? ?? 1;
    final limitSize = json['limit'] as int? ?? pagination?['limit'] as int? ?? 20;
    final pages = limitSize > 0 ? (totalCount / limitSize).ceil() : 0;
    
    final hasNextPage = pagination?['hasNext'] as bool? ?? (currentPage < pages);
    final hasPrevPage = pagination?['hasPrev'] as bool? ?? (currentPage > 1);

    return GetAllUsersAdminResponse(
      users: usersData
          .map((userJson) => UserByRoleModel.fromJson(userJson as Map<String, dynamic>))
          .toList(),
      total: totalCount,
      page: currentPage,
      limit: limitSize,
      totalPages: pages,
      hasNext: hasNextPage,
      hasPrev: hasPrevPage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': users.map((user) => user.toJson()).toList(),
      'total': total,
      'page': page,
      'limit': limit,
      'pagination': {
        'page': page,
        'limit': limit,
        'total': total,
        'totalPages': totalPages,
        'hasNext': hasNext,
        'hasPrev': hasPrev,
      },
    };
  }

  bool get hasUsers => users.isNotEmpty;
  bool get hasNextPage => hasNext;
  bool get hasPreviousPage => hasPrev;

  @override
  String toString() {
    return 'GetAllUsersAdminResponse(total: $total, page: $page/$totalPages, users: ${users.length})';
  }
}