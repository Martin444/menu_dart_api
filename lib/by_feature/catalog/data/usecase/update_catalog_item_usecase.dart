import 'package:menu_dart_api/by_feature/catalog/data/provider/catalog_item_provider.dart';
import 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';
import 'package:menu_dart_api/by_feature/catalog/models/update_catalog_item_params.dart';

/// Use case para actualizar un item existente en un catálogo
class UpdateCatalogItemUseCase {
  final CatalogItemProvider _provider = CatalogItemProvider();

  /// Ejecuta la actualización de un item
  ///
  /// [params] Parámetros con los datos a actualizar
  ///
  /// Retorna el [CatalogItemModel] actualizado
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<CatalogItemModel> execute(UpdateCatalogItemParams params) async {
    try {
      return await _provider.updateItem(params);
    } catch (e) {
      rethrow;
    }
  }
}
