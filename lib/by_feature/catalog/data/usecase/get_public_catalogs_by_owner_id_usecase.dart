import 'package:menu_dart_api/by_feature/catalog/data/provider/catalog_provider.dart';
import 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';

class GetPublicCatalogsByOwnerIdUseCase {
  final CatalogProvider _provider = CatalogProvider();

  Future<List<CatalogModel>> execute(String ownerId) async {
    try {
      return await _provider.getPublicCatalogsByOwnerId(ownerId);
    } catch (e) {
      rethrow;
    }
  }
}