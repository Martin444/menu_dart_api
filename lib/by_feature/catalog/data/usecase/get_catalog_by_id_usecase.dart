import 'package:menu_dart_api/by_feature/catalog/data/provider/catalog_provider.dart';
import 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';

/// Use case para obtener un catálogo específico por ID
class GetCatalogByIdUseCase {
  final CatalogProvider _provider = CatalogProvider();

  /// Ejecuta la obtención de un catálogo por su ID
  ///
  /// [catalogId] ID del catálogo a obtener
  ///
  /// Retorna el [CatalogModel] con todos sus detalles
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<CatalogModel> execute(String catalogId) async {
    try {
      return await _provider.getCatalogById(catalogId);
    } catch (e) {
      rethrow;
    }
  }
}
