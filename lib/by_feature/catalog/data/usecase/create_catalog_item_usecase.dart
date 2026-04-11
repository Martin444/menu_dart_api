import 'package:menu_dart_api/by_feature/catalog/data/provider/catalog_item_provider.dart';
import 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';
import 'package:menu_dart_api/by_feature/catalog/models/create_catalog_item_params.dart';

/// Use case para crear un nuevo item en un catálogo
class CreateCatalogItemUseCase {
  final CatalogItemProvider _provider = CatalogItemProvider();

  /// Ejecuta la creación de un item en un catálogo
  ///
  /// [params] Parámetros necesarios para crear el item
  ///
  /// Retorna el [CatalogItemModel] creado
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<CatalogItemModel> execute(CreateCatalogItemParams params) async {
    try {
      return await _provider.createItem(params);
    } catch (e) {
      rethrow;
    }
  }
}
