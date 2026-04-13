import 'package:menu_dart_api/by_feature/catalog/data/provider/catalog_provider.dart';
import 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';

/// Use case para buscar catálogos públicos con filtros
class SearchPublicCatalogsUseCase {
  final CatalogProvider _provider = CatalogProvider();

  /// Ejecuta la búsqueda de catálogos públicos
  ///
  /// [query] Término de búsqueda opcional
  /// [type] Tipo de catálogo opcional (MENU, WARDROBE, etc.)
  /// [tags] Lista de tags para filtrar opcional
  ///
  /// Retorna una lista de [CatalogModel] públicos que coinciden con los filtros
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<List<CatalogModel>> execute({
    String? query,
    String? type,
    List<String>? tags,
  }) async {
    try {
      return await _provider.searchPublicCatalogs(
        query: query,
        type: type,
        tags: tags,
      );
    } catch (e) {
      rethrow;
    }
  }
}
