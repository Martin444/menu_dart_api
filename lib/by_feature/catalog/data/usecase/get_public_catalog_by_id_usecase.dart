import 'package:menu_dart_api/by_feature/catalog/data/provider/catalog_provider.dart';
import 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';

class GetPublicCatalogByIdUseCase {
  final CatalogProvider _provider = CatalogProvider();

  Future<CatalogModel> execute(String catalogId) async {
    try {
      return await _provider.getPublicCatalogById(catalogId);
    } catch (e) {
      rethrow;
    }
  }
}