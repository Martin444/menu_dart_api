import 'package:menu_dart_api/by_feature/orders/models/order_model.dart';
import 'package:menu_dart_api/by_feature/orders/provider/order_provider.dart';

class CreateOrderUseCase {
  CreateOrderUseCase();

  Future<Order> call(Order order) async {
    return await OrderProvider().createOrder(order);
  }
}
