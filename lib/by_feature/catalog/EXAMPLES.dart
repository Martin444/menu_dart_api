import 'dart:typed_data';
import 'package:menu_dart_api/by_feature/catalog/data/usecase/archive_catalog_usecase.dart';
import 'package:menu_dart_api/by_feature/catalog/data/usecase/create_catalog_usecase.dart';
import 'package:menu_dart_api/by_feature/catalog/data/usecase/delete_catalog_usecase.dart';
import 'package:menu_dart_api/by_feature/catalog/data/usecase/get_catalog_by_id_usecase.dart';
import 'package:menu_dart_api/by_feature/catalog/data/usecase/get_my_catalogs_usecase.dart';
import 'package:menu_dart_api/by_feature/catalog/data/usecase/update_catalog_usecase.dart';
import 'package:menu_dart_api/by_feature/catalog/models/create_catalog_params.dart';
import 'package:menu_dart_api/by_feature/catalog/models/update_catalog_params.dart';

/// Ejemplos de uso de los endpoints de catálogos

void main() async {
  // Asegúrate de tener configurado API.loginAccessToken antes de usar

  await example1CreateCatalog();
  await example2GetMyCatalogs();
  await example3GetCatalogById();
  await example4UpdateCatalog();
  await example5DeleteCatalog();
  await example6ArchiveCatalog();
  await exampleComplete();
}

/// Ejemplo 1: Crear un catálogo de menú con imagen
Future<void> example1CreateCatalog() async {
  print('\n--- Ejemplo 1: Crear Catálogo ---');

  // Simulamos bytes de imagen (en la práctica vendrían de un archivo)
  final Uint8List imageBytes = Uint8List(0);

  final params = CreateCatalogParams(
    catalogType: 'menu',
    name: 'Menú Principal',
    description: 'Nuestro menú con los mejores platillos',
    isPublic: true,
    metadata: {
      'cuisine': 'italian',
      'priceRange': r'$$',
      'delivery': true,
    },
    settings: {
      'allowOrders': true,
      'showPrices': true,
    },
    tags: ['italiana', 'pizza', 'pasta'],
    coverImage: imageBytes,
  );

  try {
    final catalog = await CreateCatalogUseCase().execute(params);
    print('✅ Catálogo creado exitosamente');
    print('ID: ${catalog.id}');
    print('Nombre: ${catalog.name}');
    print('Slug: ${catalog.slug}');
    print('Capacidad: ${catalog.capacity}');
    print('Items actuales: ${catalog.itemCount}');
  } catch (e) {
    print('❌ Error al crear catálogo: $e');
  }
}

/// Ejemplo 2: Obtener todos los catálogos del usuario
Future<void> example2GetMyCatalogs() async {
  print('\n--- Ejemplo 2: Obtener Mis Catálogos ---');

  try {
    // Obtener todos los catálogos
    final allCatalogs = await GetMyCatalogsUseCase().execute();
    print('📋 Total de catálogos: ${allCatalogs.length}');

    // Filtrar solo menús
    final menuCatalogs = await GetMyCatalogsUseCase().execute(type: 'menu');
    print('🍕 Total de menús: ${menuCatalogs.length}');

    // Mostrar información
    for (var catalog in allCatalogs) {
      print('  - ${catalog.name} (${catalog.catalogType})');
      print('    Items: ${catalog.itemCount}/${catalog.capacity}');
      print('    Status: ${catalog.status}');
    }
  } catch (e) {
    print('❌ Error al obtener catálogos: $e');
  }
}

/// Ejemplo 3: Obtener detalles de un catálogo específico
Future<void> example3GetCatalogById() async {
  print('\n--- Ejemplo 3: Obtener Catálogo por ID ---');

  const catalogId = '550e8400-e29b-41d4-a716-446655440000';

  try {
    final catalog = await GetCatalogByIdUseCase().execute(catalogId);
    print('✅ Catálogo encontrado');
    print('Nombre: ${catalog.name}');
    print('Descripción: ${catalog.description}');
    print('Público: ${catalog.isPublic}');
    print('Tags: ${catalog.tags?.join(", ")}');

    // Mostrar items si existen
    if (catalog.items != null && catalog.items!.isNotEmpty) {
      print('\nItems en el catálogo:');
      for (var item in catalog.items!) {
        print('  - ${item.name}: \$${item.price.toStringAsFixed(2)}');
      }
    }

    // Mostrar metadata
    if (catalog.metadata != null) {
      print('\nMetadata:');
      catalog.metadata!.forEach((key, value) {
        print('  $key: $value');
      });
    }
  } catch (e) {
    print('❌ Error al obtener catálogo: $e');
  }
}

/// Ejemplo 4: Actualizar un catálogo
Future<void> example4UpdateCatalog() async {
  print('\n--- Ejemplo 4: Actualizar Catálogo ---');

  const catalogId = '550e8400-e29b-41d4-a716-446655440000';

  // Actualización simple
  final params = UpdateCatalogParams(
    catalogId: catalogId,
    name: 'Menú Actualizado 2024',
    description: 'Renovamos nuestro menú con nuevas opciones',
    status: 'active',
  );

  try {
    final updated = await UpdateCatalogUseCase().execute(params);
    print('✅ Catálogo actualizado');
    print('Nuevo nombre: ${updated.name}');
    print('Última actualización: ${updated.updatedAt}');
  } catch (e) {
    print('❌ Error al actualizar catálogo: $e');
  }

  // Actualizar con nueva imagen y metadata
  final Uint8List newImage = Uint8List(0);

  final paramsWithImage = UpdateCatalogParams(
    catalogId: catalogId,
    isPublic: false,
    metadata: {
      'featured': true,
      'season': 'winter',
      'rating': 4.5,
    },
    tags: ['actualizado', 'destacado', 'invierno'],
    coverImage: newImage,
  );

  try {
    final updated = await UpdateCatalogUseCase().execute(paramsWithImage);
    print('✅ Catálogo actualizado con imagen y metadata');
    print('Imagen: ${updated.coverImageUrl}');
  } catch (e) {
    print('❌ Error: $e');
  }
}

/// Ejemplo 5: Eliminar un catálogo
Future<void> example5DeleteCatalog() async {
  print('\n--- Ejemplo 5: Eliminar Catálogo ---');

  const catalogId = '550e8400-e29b-41d4-a716-446655440000';

  try {
    final result = await DeleteCatalogUseCase().execute(catalogId);
    print('✅ ${result['message']}');
    print('ID eliminado: ${result['catalogId']}');
  } catch (e) {
    print('❌ Error al eliminar catálogo: $e');
  }
}

/// Ejemplo 6: Archivar un catálogo
Future<void> example6ArchiveCatalog() async {
  print('\n--- Ejemplo 6: Archivar Catálogo ---');

  const catalogId = '550e8400-e29b-41d4-a716-446655440000';

  try {
    final archived = await ArchiveCatalogUseCase().execute(catalogId);
    print('✅ Catálogo archivado');
    print('Status: ${archived.status}');
    print('Archivado en: ${archived.archivedAt}');
  } catch (e) {
    print('❌ Error al archivar catálogo: $e');
  }
}

/// Ejemplo completo: Flujo típico de trabajo
Future<void> exampleComplete() async {
  print('\n--- Ejemplo Completo: Flujo de Trabajo ---');

  final Uint8List coverImage = Uint8List(0);

  try {
    // 1. Crear un nuevo catálogo
    print('\n1️⃣ Creando catálogo...');
    final createParams = CreateCatalogParams(
      catalogType: 'menu',
      name: 'Restaurante La Bella Italia',
      description: 'Auténtica cocina italiana',
      isPublic: true,
      coverImage: coverImage,
      tags: ['italiano', 'pasta', 'pizza'],
      metadata: {
        'location': 'Centro',
        'phone': '+1234567890',
        'delivery': true,
      },
      settings: {
        'allowOrders': true,
        'showPrices': true,
        'theme': 'light',
      },
    );

    final newCatalog = await CreateCatalogUseCase().execute(createParams);
    print('✅ Catálogo creado: ${newCatalog.id}');

    // 2. Listar todos los catálogos
    print('\n2️⃣ Listando catálogos...');
    final catalogs = await GetMyCatalogsUseCase().execute();
    print('📋 Total: ${catalogs.length} catálogos');

    // 3. Obtener detalles del catálogo creado
    print('\n3️⃣ Obteniendo detalles...');
    final details = await GetCatalogByIdUseCase().execute(newCatalog.id);
    print('📖 Nombre: ${details.name}');
    print('📖 Capacidad: ${details.capacity} items');

    // 4. Actualizar el catálogo
    print('\n4️⃣ Actualizando catálogo...');
    final updateParams = UpdateCatalogParams(
      catalogId: newCatalog.id,
      description: 'Auténtica cocina italiana - Ahora con delivery gratis',
      metadata: {
        ...details.metadata ?? {},
        'freeDelivery': true,
        'minOrder': 15.0,
      },
    );

    final updated = await UpdateCatalogUseCase().execute(updateParams);
    print('✅ Actualizado: ${updated.updatedAt}');

    // 5. Archivar el catálogo
    print('\n5️⃣ Archivando catálogo...');
    final archived = await ArchiveCatalogUseCase().execute(newCatalog.id);
    print('✅ Archivado con status: ${archived.status}');

    print('\n🎉 Flujo completado exitosamente');
  } catch (e) {
    print('❌ Error en el flujo: $e');
  }
}

/// Ejemplo de manejo avanzado de errores
Future<void> exampleErrorHandling() async {
  print('\n--- Ejemplo: Manejo de Errores ---');

  try {
    final catalog = await GetCatalogByIdUseCase().execute('invalid-id');
    print(catalog.name);
  } catch (e) {
    if (e.toString().contains('404')) {
      print('⚠️ Catálogo no encontrado');
    } else if (e.toString().contains('401')) {
      print('⚠️ No autenticado - verifica tu token');
    } else if (e.toString().contains('403')) {
      print('⚠️ Sin permisos para acceder');
    } else {
      print('❌ Error inesperado: $e');
    }
  }
}

/// Ejemplo con diferentes tipos de catálogos
Future<void> exampleDifferentTypes() async {
  print('\n--- Ejemplo: Diferentes Tipos de Catálogos ---');

  // Catálogo de menú
  final menuParams = CreateCatalogParams(
    catalogType: 'menu',
    name: 'Menú del Día',
  );

  // Catálogo de guardarropa
  final wardrobeParams = CreateCatalogParams(
    catalogType: 'wardrobe',
    name: 'Colección Primavera 2024',
    tags: ['primavera', 'casual', 'formal'],
  );

  // Catálogo de productos
  final productParams = CreateCatalogParams(
    catalogType: 'product_list',
    name: 'Productos Destacados',
    settings: {'showStock': true, 'allowBackorder': false},
  );

  try {
    final menu = await CreateCatalogUseCase().execute(menuParams);
    final wardrobe = await CreateCatalogUseCase().execute(wardrobeParams);
    final products = await CreateCatalogUseCase().execute(productParams);

    print('✅ Creados 3 tipos de catálogos:');
    print('  - Menu: ${menu.id}');
    print('  - Wardrobe: ${wardrobe.id}');
    print('  - Products: ${products.id}');
  } catch (e) {
    print('❌ Error: $e');
  }
}
