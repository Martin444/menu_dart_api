import 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';
import 'package:menu_dart_api/by_feature/catalog/models/create_catalog_params.dart';
import 'package:menu_dart_api/by_feature/catalog/models/pagination_model.dart';
import 'package:menu_dart_api/by_feature/catalog/models/update_catalog_params.dart';

class PaginatedCatalogsResult {
  final List<CatalogModel> items;
  final PaginationModel pagination;

  const PaginatedCatalogsResult({
    required this.items,
    required this.pagination,
  });
}

/// Repositorio abstracto para operaciones de catálogos
abstract class CatalogRepository {
  /// Crea un nuevo catálogo
  Future<CatalogModel> createCatalog(CreateCatalogParams params);

  /// Obtiene los catálogos del usuario autenticado
  /// Retorna un mapa con listas 'linked' y 'unlinked'
  Future<Map<String, dynamic>> getMyCatalogs({String? type});

  /// Vincula un catálogo sin comercio al comercio actual del usuario
  Future<CatalogModel> assignCatalogToCommerce(String catalogId);

  /// Obtiene un catálogo específico por ID
  /// [offset] y [limit] para paginar items internos, [inStock] filtra solo disponibles
  Future<CatalogModel> getCatalogById(
    String catalogId, {
    int? offset,
    int? limit,
    bool inStock = true,
  });

  /// Actualiza un catálogo existente
  Future<CatalogModel> updateCatalog(UpdateCatalogParams params);

  /// Elimina un catálogo
  Future<Map<String, dynamic>> deleteCatalog(String catalogId);

  /// Archiva un catálogo
  Future<CatalogModel> archiveCatalog(String catalogId);

  /// Obtiene un catálogo público por su slug
  /// [inStock] filtra solo items disponibles
  Future<CatalogModel> getPublicCatalogBySlug(String slug, {bool inStock = true});

  /// Busca catálogos públicos con filtros y paginación
  Future<PaginatedCatalogsResult> searchPublicCatalogs({
    String? query,
    String? type,
    List<String>? tags,
    int offset = 0,
    int limit = 20,
  });

  /// Obtiene un catálogo público por su ID (sin autenticación)
  /// [inStock] filtra solo items disponibles
  Future<CatalogModel> getPublicCatalogById(String catalogId, {bool inStock = true});

  /// Obtiene catálogos públicos por ownerId (sin autenticación)
  Future<List<CatalogModel>> getPublicCatalogsByOwnerId(String ownerId);

  /// Obtiene catálogos públicos de un comercio por slug o UUID
  /// [offset] y [limit] para paginación, [inStock] filtra solo disponibles
  Future<PaginatedCatalogsResult> getPublicCatalogsByCommerce(
    String identifier, {
    int offset = 0,
    int limit = 50,
    bool inStock = true,
  });
}
