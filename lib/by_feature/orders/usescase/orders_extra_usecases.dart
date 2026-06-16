import 'package:menu_dart_api/by_feature/orders/models/order_model.dart';
import 'package:menu_dart_api/by_feature/orders/provider/order_provider.dart';

class GetOrdersByAnonymousUseCase {
  GetOrdersByAnonymousUseCase();

  Future<List<Order>> call(String anonymousId) async {
    return await OrderProvider().getOrdersByAnonymous(anonymousId);
  }
}

class GetOrderByIdUseCase {
  GetOrderByIdUseCase();

  Future<Order> call(String orderId) async {
    return await OrderProvider().getOrderById(orderId);
  }
}

class UpdateOrderUseCase {
  UpdateOrderUseCase();

  Future<Order> call(String orderId, Map<String, dynamic> data) async {
    return await OrderProvider().updateOrder(orderId, data);
  }
}

class UpdateOrderStatusUseCase {
  UpdateOrderStatusUseCase();

  Future<Order> call(String orderId, String status) async {
    return await OrderProvider().updateOrderStatus(orderId, status);
  }
}

class DeleteOrderUseCase {
  DeleteOrderUseCase();

  Future<void> call(String orderId) async {
    await OrderProvider().deleteOrder(orderId);
  }
}
