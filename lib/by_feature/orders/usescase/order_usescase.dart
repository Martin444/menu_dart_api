import 'package:menu_dart_api/by_feature/orders/models/order_model.dart';
import 'package:menu_dart_api/by_feature/orders/models/paginated_orders_response.dart';
import 'package:menu_dart_api/by_feature/orders/provider/order_provider.dart';

class CreateOrderUseCase {
  CreateOrderUseCase();

  Future<Order> call(Order order) async {
    return await OrderProvider().createOrder(order);
  }
}

class GetOrdersByBusinessOwnerUseCase {
  GetOrdersByBusinessOwnerUseCase();

  Future<PaginatedOrdersResponse> call(String businessOwnerId, {int? page, int? limit}) async {
    return await OrderProvider().getOrdersByBusinessOwner(businessOwnerId, page: page, limit: limit);
  }
}

class GetOrdersByOwnerUseCase {
  GetOrdersByOwnerUseCase();

  Future<PaginatedOrdersResponse> call({int? page, int? limit}) async {
    return await OrderProvider().getOrdersByOwner(page: page, limit: limit);
  }
}

class GetOrdersAdminUseCase {
  GetOrdersAdminUseCase();

  Future<PaginatedOrdersResponse> call({int? page, int? limit}) async {
    return await OrderProvider().getOrdersAdmin(page: page, limit: limit);
  }
}
