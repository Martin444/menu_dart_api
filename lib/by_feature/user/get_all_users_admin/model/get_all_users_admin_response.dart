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
    final innerData = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : null;
    
    final pagination = innerData?['pagination'] is Map<String, dynamic>
        ? innerData!['pagination'] as Map<String, dynamic>
        : (json['pagination'] is Map<String, dynamic>
            ? json['pagination'] as Map<String, dynamic>
            : null);
    
    final usersData = innerData?['data'] is List
        ? innerData!['data'] as List
        : (json['data'] is List ? json['data'] as List : []);
    
    // Defensive parsing for total, page, limit
    final totalValueStr = (json['total'] ?? pagination?['total'] ?? '0').toString();
    final totalCount = int.tryParse(totalValueStr) ?? 0;
    
    final pageValueStr = (json['page'] ?? pagination?['page'] ?? '1').toString();
    final currentPage = int.tryParse(pageValueStr) ?? 1;
    
    final limitValueStr = (json['limit'] ?? pagination?['limit'] ?? '20').toString();
    final limitSize = int.tryParse(limitValueStr) ?? 20;
    
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