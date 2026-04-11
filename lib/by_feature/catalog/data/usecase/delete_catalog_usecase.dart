import 'package:menu_dart_api/by_feature/catalog/data/provider/catalog_provider.dart';

/// Use case para eliminar un catálogo
class DeleteCatalogUseCase {
  final CatalogProvider _provider = CatalogProvider();

  /// Ejecuta la eliminación de un catálogo
  ///
  /// [catalogId] ID del catálogo a eliminar
  ///
  /// Retorna un Map con el mensaje de confirmación
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<Map<String, dynamic>> execute(String catalogId) async {
    try {
      return await _provider.deleteCatalog(catalogId);
    } catch (e) {
      rethrow;
    }
  }
}
