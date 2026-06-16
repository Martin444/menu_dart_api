import 'package:menu_dart_api/by_feature/commerce/models/commerce.dart';
import 'package:menu_dart_api/by_feature/commerce/models/commerce_requests.dart';

abstract class CommerceRepository {
  Future<Commerce> create(CreateCommerceRequest request);
  Future<List<Commerce>> getMyCommerces();
  Future<Commerce> getById(String commerceId);
  Future<Commerce> update(String commerceId, UpdateCommerceRequest request);
  Future<void> delete(String commerceId);
}
