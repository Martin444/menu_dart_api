import 'package:menu_dart_api/by_feature/catalog/data/provider/catalog_provider.dart';
import 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';

/// Use case para archivar un catálogo
class ArchiveCatalogUseCase {
  final CatalogProvider _provider = CatalogProvider();

  /// Ejecuta el archivado de un catálogo
  ///
  /// [catalogId] ID del catálogo a archivar
  ///
  /// Retorna el [CatalogModel] con status 'archived'
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<CatalogModel> execute(String catalogId) async {
    try {
      return await _provider.archiveCatalog(catalogId);
    } catch (e) {
      rethrow;
    }
  }
}
