import 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';
import 'package:menu_dart_api/by_feature/catalog/models/create_catalog_params.dart';
import 'package:menu_dart_api/by_feature/catalog/models/update_catalog_params.dart';

/// Repositorio abstracto para operaciones de catálogos
abstract class CatalogRepository {
  /// Crea un nuevo catálogo
  Future<CatalogModel> createCatalog(CreateCatalogParams params);

  /// Obtiene los catálogos del usuario autenticado
  Future<List<CatalogModel>> getMyCatalogs({String? type});

  /// Obtiene un catálogo específico por ID
  Future<CatalogModel> getCatalogById(String catalogId);

  /// Actualiza un catálogo existente
  Future<CatalogModel> updateCatalog(UpdateCatalogParams params);

  /// Elimina un catálogo
  Future<Map<String, dynamic>> deleteCatalog(String catalogId);

  /// Archiva un catálogo
  Future<CatalogModel> archiveCatalog(String catalogId);

  /// Obtiene un catálogo público por su slug
  Future<CatalogModel> getPublicCatalogBySlug(String slug);

  /// Busca catálogos públicos con filtros
  Future<List<CatalogModel>> searchPublicCatalogs({
    String? query,
    String? type,
    List<String>? tags,
  });

  /// Obtiene un catálogo público por su ID (sin autenticación)
  Future<CatalogModel> getPublicCatalogById(String catalogId);

  /// Obtiene catálogos públicos por ownerId (sin autenticación)
  Future<List<CatalogModel>> getPublicCatalogsByOwnerId(String ownerId);
}
