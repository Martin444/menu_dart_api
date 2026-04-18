import 'package:menu_dart_api/menu_com_api.dart';

abstract class OrderRepository {
  Future<List<Order>> getOrdersByUserId(String userId);

  Future<List<Order>> getOrdersByBusinessOwner(String businessOwnerId, {int? page, int? limit});

  Future<Order> getOrderById(String orderId);

  Future<void> createOrder(Order order);

  Future<void> updateOrder(Order order);

  Future<void> deleteOrder(String orderId);

  Future<List<OrderItemModel>> getOrderItemsByOrderId(String orderId);

  Future<void> addOrderItem(OrderItemModel orderItem);

  Future<void> removeOrderItem(String orderItemId);
}
