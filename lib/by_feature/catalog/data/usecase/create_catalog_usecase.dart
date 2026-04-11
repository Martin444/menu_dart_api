import 'package:menu_dart_api/by_feature/catalog/data/provider/catalog_provider.dart';
import 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';
import 'package:menu_dart_api/by_feature/catalog/models/create_catalog_params.dart';

/// Use case para crear un nuevo catálogo
class CreateCatalogUseCase {
  final CatalogProvider _provider = CatalogProvider();

  /// Ejecuta la creación de un catálogo
  ///
  /// [params] Parámetros necesarios para crear el catálogo
  ///
  /// Retorna el [CatalogModel] creado
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<CatalogModel> execute(CreateCatalogParams params) async {
    try {
      return await _provider.createCatalog(params);
    } catch (e) {
      rethrow;
    }
  }
}
