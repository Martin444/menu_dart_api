import 'package:menu_dart_api/by_feature/catalog/data/provider/catalog_provider.dart';
import 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';
import 'package:menu_dart_api/by_feature/catalog/models/update_catalog_params.dart';

/// Use case para actualizar un catálogo existente
class UpdateCatalogUseCase {
  final CatalogProvider _provider = CatalogProvider();

  /// Ejecuta la actualización de un catálogo
  ///
  /// [params] Parámetros con los datos a actualizar
  ///
  /// Retorna el [CatalogModel] actualizado
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<CatalogModel> execute(UpdateCatalogParams params) async {
    try {
      return await _provider.updateCatalog(params);
    } catch (e) {
      rethrow;
    }
  }
}
