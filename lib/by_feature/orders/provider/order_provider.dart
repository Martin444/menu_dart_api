import 'dart:convert';

import 'package:menu_dart_api/by_feature/orders/repository/order_repository.dart';
import 'package:http/http.dart' as http;
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
      var response = await http.post(
        wardrobeCreateURl,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${API.loginAccessToken}',
        },
        body: jsonEncode(order.toJson()),
      );
      return response.statusCode == 201 || response.statusCode == 200
          ? Future.value(Order.fromJson(jsonDecode(response.body)))
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
  Future<void> removeOrderItem(String orderItemId) {
    // TODO: implement removeOrderItem
    throw UnimplementedError();
  }

  @override
  Future<void> updateOrder(Order order) {
    // TODO: implement updateOrder
    throw UnimplementedError();
  }
}
