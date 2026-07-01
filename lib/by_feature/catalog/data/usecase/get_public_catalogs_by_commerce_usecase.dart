import 'package:menu_dart_api/by_feature/catalog/data/provider/catalog_provider.dart';
import 'package:menu_dart_api/by_feature/catalog/data/repository/catalog_repository.dart';

class GetPublicCatalogsByCommerceUseCase {
  final CatalogProvider _provider = CatalogProvider();

  /// [identifier] Slug o UUID del comercio
  /// [offset] Desplazamiento para paginación
  /// [limit] Límite de catálogos por página
  /// [inStock] Filtra solo items disponibles
  Future<PaginatedCatalogsResult> execute(
    String identifier, {
    int offset = 0,
    int limit = 50,
    bool inStock = true,
  }) async {
    try {
      return await _provider.getPublicCatalogsByCommerce(
        identifier,
        offset: offset,
        limit: limit,
        inStock: inStock,
      );
    } catch (e) {
      rethrow;
    }
  }
}
