import 'package:menu_dart_api/by_feature/catalog/data/provider/catalog_provider.dart';
import 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';

/// Use case para obtener los catálogos del usuario
class GetMyCatalogsUseCase {
  final CatalogProvider _provider = CatalogProvider();

  /// Ejecuta la obtención de catálogos del usuario autenticado
  ///
  /// [type] Tipo de catálogo opcional para filtrar (menu, wardrobe, product_list, etc.)
  ///
  /// Retorna un mapa con listas 'linked' y 'unlinked' de [CatalogModel]
  ///
  /// Lanza [ApiException] si hay error en la petición
  Future<Map<String, dynamic>> execute({String? type}) async {
    try {
      return await _provider.getMyCatalogs(type: type);
    } catch (e) {
      rethrow;
    }
  }
}
