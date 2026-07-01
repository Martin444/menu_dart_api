import 'package:menu_dart_api/by_feature/catalog/data/provider/catalog_provider.dart';
import 'package:menu_dart_api/by_feature/catalog/data/repository/catalog_repository.dart';

/// Use case para buscar catálogos públicos con filtros y paginación
class SearchPublicCatalogsUseCase {
  final CatalogProvider _provider = CatalogProvider();

  /// Ejecuta la búsqueda de catálogos públicos
  ///
  /// [query] Término de búsqueda opcional
  /// [type] Tipo de catálogo opcional (MENU, WARDROBE, etc.)
  /// [tags] Lista de tags para filtrar opcional
  /// [offset] Desplazamiento para paginación
  /// [limit] Límite de resultados por página
  ///
  /// Retorna un [PaginatedCatalogsResult] con items y paginación
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<PaginatedCatalogsResult> execute({
    String? query,
    String? type,
    List<String>? tags,
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      return await _provider.searchPublicCatalogs(
        query: query,
        type: type,
        tags: tags,
        offset: offset,
        limit: limit,
      );
    } catch (e) {
      rethrow;
    }
  }
}
