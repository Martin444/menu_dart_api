import 'package:menu_dart_api/by_feature/catalog/data/provider/catalog_item_provider.dart';
import 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';

/// Use case para obtener un item específico de un catálogo
class GetCatalogItemByIdUseCase {
  final CatalogItemProvider _provider = CatalogItemProvider();

  /// Ejecuta la obtención de un item por su ID
  ///
  /// [catalogId] ID del catálogo que contiene el item
  /// [itemId] ID del item a obtener
  ///
  /// Retorna el [CatalogItemModel] con todos sus detalles
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<CatalogItemModel> execute({
    required String catalogId,
    required String itemId,
  }) async {
    try {
      return await _provider.getItemById(
        catalogId: catalogId,
        itemId: itemId,
      );
    } catch (e) {
      rethrow;
    }
  }
}
