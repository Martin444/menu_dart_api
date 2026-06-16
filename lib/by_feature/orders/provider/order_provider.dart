import 'dart:convert';

import 'package:menu_dart_api/by_feature/orders/models/paginated_orders_response.dart';
import 'package:menu_dart_api/by_feature/orders/repository/order_repository.dart';
import 'package:menu_dart_api/menu_com_api.dart';

class OrderProvider extends OrderRepository {
  @override
  Future<void> addOrderItem(OrderItemModel orderItem) {
    throw UnimplementedError();
  }

  @override
  Future<Order> createOrder(Order order) async {
    try {
      Uri url = Uri.parse('${API.defaulBaseUrl}/orders');
      var response = await API.httpClient.post(
        url,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
        body: jsonEncode(order.toJson()),
      );
      return response.statusCode == 201 || response.statusCode == 200
          ? Order.fromJson((jsonDecode(response.body) as Map<String, dynamic>)['data'] as Map<String, dynamic>)
          : Future.error('Failed to create order');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteOrder(String orderId) async {
    try {
      Uri url = Uri.parse('${API.defaulBaseUrl}/orders/$orderId');
      var response = await API.httpClient.delete(
        url,
        headers: {'Authorization': 'Bearer ${API.loginAccessToken}'},
      );
      if (response.statusCode != 200) {
        throw ApiException(response.statusCode, 'Error al eliminar orden');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Order> getOrderById(String orderId) async {
    try {
      Uri url = Uri.parse('${API.defaulBaseUrl}/orders/$orderId');
      var response = await API.httpClient.get(
        url,
        headers: {'Authorization': 'Bearer ${API.loginAccessToken}'},
      );
      if (response.statusCode != 200) {
        throw ApiException(response.statusCode, 'Error al obtener orden');
      }
      final decoded = jsonDecode(response.body);
      final data = decoded is Map<String, dynamic>
          ? (decoded['data'] ?? decoded)
          : decoded;
      return Order.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<OrderItemModel>> getOrderItemsByOrderId(String orderId) {
    throw UnimplementedError();
  }

  @override
  Future<List<Order>> getOrdersByUserId(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<List<Order>> getOrdersByAnonymous(String anonymousId) async {
    try {
      Uri url = Uri.parse('${API.defaulBaseUrl}/orders/byAnonymous');
      var response = await API.httpClient.get(
        url,
        headers: {'x-anonymous-id': anonymousId},
      );
      if (response.statusCode != 200) {
        throw ApiException(response.statusCode, 'Error al obtener órdenes anónimas');
      }
      final decoded = jsonDecode(response.body);
      final List<dynamic> list = decoded is List ? decoded : (decoded['data'] as List<dynamic>? ?? []);
      return list.map((e) => Order.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PaginatedOrdersResponse> getOrdersByBusinessOwner(String businessOwnerId, {int? page, int? limit}) async {
    try {
      String urlString = '${API.defaulBaseUrl}/orders/byBusinessOwner/$businessOwnerId';
      final queryParams = <String>[];
      if (page != null) queryParams.add('page=$page');
      if (limit != null) queryParams.add('limit=$limit');
      if (queryParams.isNotEmpty) urlString += '?${queryParams.join('&')}';

      Uri url = Uri.parse(urlString);
      var response = await API.httpClient.get(
        url,
        headers: {'Authorization': 'Bearer ${API.loginAccessToken}'},
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
    throw UnimplementedError();
  }

  @override
  Future<Order> updateOrder(String orderId, Map<String, dynamic> data) async {
    try {
      Uri url = Uri.parse('${API.defaulBaseUrl}/orders/$orderId');
      var response = await API.httpClient.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode != 200) {
        throw ApiException(response.statusCode, 'Error al actualizar orden');
      }
      final decoded = jsonDecode(response.body);
      final orderData = decoded is Map<String, dynamic>
          ? (decoded['data'] ?? decoded)
          : decoded;
      return Order.fromJson(orderData as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Order> updateOrderStatus(String orderId, String status) async {
    try {
      Uri url = Uri.parse('${API.defaulBaseUrl}/orders/$orderId/status');
      var response = await API.httpClient.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
        body: jsonEncode({'status': status}),
      );
      if (response.statusCode != 200) {
        throw ApiException(response.statusCode, 'Error al actualizar estado de orden');
      }
      final decoded = jsonDecode(response.body);
      final orderData = decoded is Map<String, dynamic>
          ? (decoded['data'] ?? decoded)
          : decoded;
      return Order.fromJson(orderData as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PaginatedOrdersResponse> getOrdersByOwner({int? page, int? limit}) async {
    try {
      String urlString = '${API.defaulBaseUrl}/orders/byOwner';
      final queryParams = <String>[];
      if (page != null) queryParams.add('page=$page');
      if (limit != null) queryParams.add('limit=$limit');
      if (queryParams.isNotEmpty) urlString += '?${queryParams.join('&')}';

      Uri url = Uri.parse(urlString);
      var response = await API.httpClient.get(
        url,
        headers: {'Authorization': 'Bearer ${API.loginAccessToken}'},
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
      if (queryParams.isNotEmpty) urlString += '?${queryParams.join('&')}';

      Uri url = Uri.parse(urlString);
      var response = await API.httpClient.get(
        url,
        headers: {'Authorization': 'Bearer ${API.loginAccessToken}'},
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
