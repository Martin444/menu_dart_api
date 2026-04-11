import 'package:menu_dart_api/by_feature/catalog/data/provider/catalog_item_provider.dart';

/// Use case para eliminar un item de un catálogo
class DeleteCatalogItemUseCase {
  final CatalogItemProvider _provider = CatalogItemProvider();

  /// Ejecuta la eliminación de un item
  ///
  /// [catalogId] ID del catálogo que contiene el item
  /// [itemId] ID del item a eliminar
  ///
  /// Retorna un Map con el mensaje de confirmación
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<Map<String, dynamic>> execute({
    required String catalogId,
    required String itemId,
  }) async {
    try {
      return await _provider.deleteItem(
        catalogId: catalogId,
        itemId: itemId,
      );
    } catch (e) {
      rethrow;
    }
  }
}
