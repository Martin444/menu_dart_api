import 'package:menu_dart_api/by_feature/orders/models/paginated_orders_response.dart';
import 'package:menu_dart_api/menu_com_api.dart';

abstract class OrderRepository {
  Future<List<Order>> getOrdersByUserId(String userId);

  Future<PaginatedOrdersResponse> getOrdersByBusinessOwner(String businessOwnerId, {int? page, int? limit});

  Future<PaginatedOrdersResponse> getOrdersByOwner({int? page, int? limit});

  Future<PaginatedOrdersResponse> getOrdersAdmin({int? page, int? limit});

  Future<Order> getOrderById(String orderId);

  Future<void> createOrder(Order order);

  Future<void> updateOrder(Order order);

  Future<void> deleteOrder(String orderId);

  Future<List<OrderItemModel>> getOrderItemsByOrderId(String orderId);

  Future<void> addOrderItem(OrderItemModel orderItem);

  Future<void> removeOrderItem(String orderItemId);
}
