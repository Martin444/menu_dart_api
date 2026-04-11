import 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';
import 'package:menu_dart_api/by_feature/catalog/models/create_catalog_item_params.dart';
import 'package:menu_dart_api/by_feature/catalog/models/update_catalog_item_params.dart';

/// Repositorio abstracto para operaciones de items de catálogos
abstract class CatalogItemRepository {
  /// Crea un nuevo item en un catálogo
  Future<CatalogItemModel> createItem(CreateCatalogItemParams params);

  /// Obtiene un item específico por ID
  Future<CatalogItemModel> getItemById({
    required String catalogId,
    required String itemId,
  });

  /// Actualiza un item existente
  Future<CatalogItemModel> updateItem(UpdateCatalogItemParams params);

  /// Elimina un item
  Future<Map<String, dynamic>> deleteItem({
    required String catalogId,
    required String itemId,
  });
}
