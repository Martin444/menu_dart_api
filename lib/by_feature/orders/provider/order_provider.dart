import 'dart:convert';

import 'package:menu_dart_api/by_feature/orders/models/paginated_orders_response.dart';
import 'package:menu_dart_api/by_feature/orders/repository/order_repository.dart';
import 'package:menu_dart_api/menu_com_api.dart';

class OrderProvider extends OrderRepository {
  @override
  Future<void> addOrderItem(OrderItemModel orderItem) {
    // TODO: implement addOrderItem
    throw UnimplementedError();
  }

  @override
  Future<Order> createOrder(Order order) async {
    try {
      Uri wardrobeCreateURl = Uri.parse('${API.defaulBaseUrl}/orders');
      var response = await API.httpClient.post(
        wardrobeCreateURl,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
        body: jsonEncode(order.toJson()),
      );
      return response.statusCode == 201 || response.statusCode == 200
          ? Future.value(Order.fromJson((jsonDecode(response.body) as Map<String, dynamic>)['data'] as Map<String, dynamic>))
          : Future.error('Failed to create order');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteOrder(String orderId) {
    // TODO: implement deleteOrder
    throw UnimplementedError();
  }

  @override
  Future<Order> getOrderById(String orderId) {
    // TODO: implement getOrderById
    throw UnimplementedError();
  }

  @override
  Future<List<OrderItemModel>> getOrderItemsByOrderId(String orderId) {
    // TODO: implement getOrderItemsByOrderId
    throw UnimplementedError();
  }

  @override
  Future<List<Order>> getOrdersByUserId(String userId) {
    // TODO: implement getOrdersByUserId
    throw UnimplementedError();
  }

  @override
  Future<PaginatedOrdersResponse> getOrdersByBusinessOwner(String businessOwnerId, {int? page, int? limit}) async {
    try {
      String urlString = '${API.defaulBaseUrl}/orders/byBusinessOwner/$businessOwnerId';
      
      final queryParams = <String>[];
      if (page != null) queryParams.add('page=$page');
      if (limit != null) queryParams.add('limit=$limit');
      
      if (queryParams.isNotEmpty) {
        urlString += '?${queryParams.join('&')}';
      }
      
      Uri ordersUrl = Uri.parse(urlString);
      var response = await API.httpClient.get(
        ordersUrl,
        headers: {
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          return PaginatedOrdersResponse.fromJson(decoded);
        } else if (decoded is List) {
          return PaginatedOrdersResponse(
            orders: decoded.map((item) => Order.fromJson(item as Map<String, dynamic>)).toList(),
          );
        }
        return PaginatedOrdersResponse(orders: []);
      } else {
        throw Exception('Failed to load orders by business owner: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeOrderItem(String orderItemId) {
    // TODO: implement removeOrderItem
    throw UnimplementedError();
  }

  @override
  Future<void> updateOrder(Order order) {
    // TODO: implement updateOrder
    throw UnimplementedError();
  }

  @override
  Future<PaginatedOrdersResponse> getOrdersByOwner({int? page, int? limit}) async {
    try {
      String urlString = '${API.defaulBaseUrl}/orders/byOwner';
      
      final queryParams = <String>[];
      if (page != null) queryParams.add('page=$page');
      if (limit != null) queryParams.add('limit=$limit');
      
      if (queryParams.isNotEmpty) {
        urlString += '?${queryParams.join('&')}';
      }
      
      Uri ordersUrl = Uri.parse(urlString);
      var response = await API.httpClient.get(
        ordersUrl,
        headers: {
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          return PaginatedOrdersResponse.fromJson(decoded);
        } else if (decoded is List) {
          return PaginatedOrdersResponse(
            orders: decoded.map((item) => Order.fromJson(item as Map<String, dynamic>)).toList(),
          );
        }
        return PaginatedOrdersResponse(orders: []);
      } else {
        throw Exception('Failed to load orders by owner: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PaginatedOrdersResponse> getOrdersAdmin({int? page, int? limit}) async {
    try {
      String urlString = '${API.defaulBaseUrl}/orders/admin/all';
      
      final queryParams = <String>[];
      if (page != null) queryParams.add('page=$page');
      if (limit != null) queryParams.add('limit=$limit');
      
      if (queryParams.isNotEmpty) {
        urlString += '?${queryParams.join('&')}';
      }
      
      Uri ordersUrl = Uri.parse(urlString);
      var response = await API.httpClient.get(
        ordersUrl,
        headers: {
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          return PaginatedOrdersResponse.fromJson(decoded);
        } else if (decoded is List) {
          return PaginatedOrdersResponse(
            orders: decoded.map((item) => Order.fromJson(item as Map<String, dynamic>)).toList(),
          );
        }
        return PaginatedOrdersResponse(orders: []);
      } else {
        throw Exception('Failed to load all orders (admin): ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
