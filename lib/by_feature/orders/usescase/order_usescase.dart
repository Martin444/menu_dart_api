import 'package:menu_dart_api/by_feature/orders/models/order_model.dart';
import 'package:menu_dart_api/by_feature/orders/provider/order_provider.dart';

class CreateOrderUseCase {
  CreateOrderUseCase();

  Future<Order> call(Order order) async {
    return await OrderProvider().createOrder(order);
  }
}

class GetOrdersByBusinessOwnerUseCase {
  GetOrdersByBusinessOwnerUseCase();

  Future<List<Order>> call(String businessOwnerId, {int? page, int? limit}) async {
    return await OrderProvider().getOrdersByBusinessOwner(businessOwnerId, page: page, limit: limit);
  }
}

class GetOrdersByOwnerUseCase {
  GetOrdersByOwnerUseCase();

  Future<List<Order>> call({int? page, int? limit}) async {
    return await OrderProvider().getOrdersByOwner(page: page, limit: limit);
  }
}
