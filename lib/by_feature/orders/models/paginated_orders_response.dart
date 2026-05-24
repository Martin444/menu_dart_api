import 'package:menu_dart_api/by_feature/orders/models/order_model.dart';

class PaginationInfo {
  final int page;
  final int limit;
  final int total;
  final int totalPages;
  final bool hasNext;
  final bool hasPrev;

  PaginationInfo({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrev,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 20,
      total: (json['total'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 1,
      hasNext: json['hasNext'] ?? false,
      hasPrev: json['hasPrev'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
      'totalPages': totalPages,
      'hasNext': hasNext,
      'hasPrev': hasPrev,
    };
  }
}

class PaginatedOrdersResponse {
  final List<Order> orders;
  final PaginationInfo? pagination;
  final int? statusCode;
  final String? message;

  PaginatedOrdersResponse({
    required this.orders,
    this.pagination,
    this.statusCode,
    this.message,
  });

  factory PaginatedOrdersResponse.fromJson(Map<String, dynamic> json) {
    List<Order> ordersList = [];
    if (json['data'] is List) {
      ordersList = (json['data'] as List)
          .map((item) => Order.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (json['orders'] is List) {
      ordersList = (json['orders'] as List)
          .map((item) => Order.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    PaginationInfo? paginationInfo;
    if (json['pagination'] is Map<String, dynamic>) {
      paginationInfo = PaginationInfo.fromJson(json['pagination'] as Map<String, dynamic>);
    }

    return PaginatedOrdersResponse(
      orders: ordersList,
      pagination: paginationInfo,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      message: json['message']?.toString(),
    );
  }
}
