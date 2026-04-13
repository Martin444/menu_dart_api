import 'package:menu_dart_api/by_feature/catalog/data/provider/catalog_provider.dart';
import 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';

/// Use case para obtener un catálogo público por su slug
class GetPublicCatalogBySlugUseCase {
  final CatalogProvider _provider = CatalogProvider();

  /// Ejecuta la obtención de un catálogo público por su slug
  ///
  /// [slug] Slug único del catálogo público
  ///
  /// Retorna el [CatalogModel] público con todos sus detalles
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<CatalogModel> execute(String slug) async {
    try {
      return await _provider.getPublicCatalogBySlug(slug);
    } catch (e) {
      rethrow;
    }
  }
}
