# 📦 Catalog Feature - Documentación

Implementación completa de los endpoints de catálogos siguiendo la arquitectura modular del proyecto.

## 📁 Estructura

```
lib/by_feature/catalog/
├── models/
│   ├── catalog_model.dart                # Modelo principal de catálogo e items
│   ├── create_catalog_params.dart        # Parámetros para crear catálogo
│   ├── update_catalog_params.dart        # Parámetros para actualizar catálogo
│   ├── create_catalog_item_params.dart   # Parámetros para crear items
│   └── update_catalog_item_params.dart   # Parámetros para actualizar items
├── data/
│   ├── repository/
│   │   ├── catalog_repository.dart       # Interfaz abstracta de catálogos
│   │   └── catalog_item_repository.dart  # Interfaz abstracta de items
│   ├── provider/
│   │   ├── catalog_provider.dart         # Implementación endpoints catálogos
│   │   └── catalog_item_provider.dart    # Implementación endpoints items
│   └── usecase/
│       ├── create_catalog_usecase.dart
│       ├── get_my_catalogs_usecase.dart
│       ├── get_catalog_by_id_usecase.dart
│       ├── update_catalog_usecase.dart
│       ├── delete_catalog_usecase.dart
│       ├── archive_catalog_usecase.dart
│       ├── create_catalog_item_usecase.dart
│       ├── get_catalog_item_by_id_usecase.dart
│       ├── update_catalog_item_usecase.dart
│       └── delete_catalog_item_usecase.dart
```

## 🔧 Helpers Reutilizables

### MultipartHelper

Ubicado en `lib/core/helpers/multipart_helper.dart`, proporciona funciones para manejar datos multipart/form-data:

- `encodeJson()`: Convierte Map a JSON string
- `encodeTags()`: Convierte lista de strings a formato separado por comas
- `encodeBool()`: Convierte boolean a string
- `generateFilename()`: Genera nombres únicos para archivos

## 📖 Uso

### 1. Crear Catálogo

```dart
import 'dart:typed_data';
import 'package:menu_dart_api/by_feature/catalog/data/usecase/create_catalog_usecase.dart';
import 'package:menu_dart_api/by_feature/catalog/models/create_catalog_params.dart';

// Con imagen
final params = CreateCatalogParams(
  catalogType: 'menu',
  name: 'Menú Principal',
  description: 'Nuestro menú con los mejores platillos',
  isPublic: true,
  metadata: {
    'cuisine': 'italian',
    'priceRange': r'$$',
  },
  settings: {
    'allowOrders': true,
    'showPrices': true,
  },
  tags: ['italiana', 'pizza', 'pasta'],
  coverImage: imageBytes, // Uint8List
);

try {
  final catalog = await CreateCatalogUseCase().execute(params);
  print('Catálogo creado: ${catalog.id}');
  print('Capacidad: ${catalog.capacity}');
  print('Items: ${catalog.itemCount}');
} catch (e) {
  print('Error: $e');
}

// Sin imagen
final simpleParams = CreateCatalogParams(
  catalogType: 'wardrobe',
  name: 'Mi Guardarropa',
);

final catalog = await CreateCatalogUseCase().execute(simpleParams);
```

### 2. Obtener Mis Catálogos

```dart
import 'package:menu_dart_api/by_feature/catalog/data/usecase/get_my_catalogs_usecase.dart';

// Todos los catálogos
final allCatalogs = await GetMyCatalogsUseCase().execute();

// Filtrar por tipo
final menuCatalogs = await GetMyCatalogsUseCase().execute(type: 'menu');
final wardrobes = await GetMyCatalogsUseCase().execute(type: 'wardrobe');

for (var catalog in allCatalogs) {
  print('${catalog.name} - ${catalog.itemCount}/${catalog.capacity} items');
}
```

### 3. Obtener Catálogo por ID

```dart
import 'package:menu_dart_api/by_feature/catalog/data/usecase/get_catalog_by_id_usecase.dart';

final catalog = await GetCatalogByIdUseCase().execute('550e8400-e29b-41d4-a716-446655440000');

print('Nombre: ${catalog.name}');
print('Slug: ${catalog.slug}');
print('Público: ${catalog.isPublic}');
print('Items:');
catalog.items?.forEach((item) {
  print('  - ${item.name}: \$${item.price}');
});
```

### 4. Actualizar Catálogo

```dart
import 'package:menu_dart_api/by_feature/catalog/models/update_catalog_params.dart';
import 'package:menu_dart_api/by_feature/catalog/data/usecase/update_catalog_usecase.dart';

// Actualizar solo nombre y descripción
final params = UpdateCatalogParams(
  catalogId: '550e8400-e29b-41d4-a716-446655440000',
  name: 'Menú Actualizado',
  description: 'Nueva descripción',
);

final updated = await UpdateCatalogUseCase().execute(params);

// Actualizar con nueva imagen
final paramsWithImage = UpdateCatalogParams(
  catalogId: '550e8400-e29b-41d4-a716-446655440000',
  name: 'Menú Renovado',
  status: 'active',
  isPublic: false,
  coverImage: newImageBytes,
  tags: ['nuevo', 'actualizado'],
);

final updatedWithImage = await UpdateCatalogUseCase().execute(paramsWithImage);

// Cambiar metadata y settings
final paramsWithMeta = UpdateCatalogParams(
  catalogId: '550e8400-e29b-41d4-a716-446655440000',
  metadata: {'newKey': 'newValue', 'updated': true},
  settings: {'theme': 'dark', 'notifications': true},
);

await UpdateCatalogUseCase().execute(paramsWithMeta);
```

### 5. Eliminar Catálogo

```dart
import 'package:menu_dart_api/by_feature/catalog/data/usecase/delete_catalog_usecase.dart';

final result = await DeleteCatalogUseCase().execute('550e8400-e29b-41d4-a716-446655440000');

print(result['message']); // "Catálogo eliminado exitosamente"
```

### 6. Archivar Catálogo

```dart
import 'package:menu_dart_api/by_feature/catalog/data/usecase/archive_catalog_usecase.dart';

final archived = await ArchiveCatalogUseCase().execute('550e8400-e29b-41d4-a716-446655440000');

print('Status: ${archived.status}'); // "archived"
print('Archivado en: ${archived.archivedAt}');
```

## 🎯 Tipos de Catálogo

Valores válidos para `catalogType`:
- `menu` - Menús de restaurante
- `wardrobe` - Guardarropas
- `product_list` - Listas de productos
- `service_list` - Listas de servicios
- `marketplace` - Marketplaces

## 📊 Estados de Catálogo

Valores válidos para `status`:
- `active` - Activo
- `draft` - Borrador
- `inactive` - Inactivo
- `archived` - Archivado

## 🔐 Autenticación

Todos los endpoints requieren autenticación. El token se toma automáticamente de `API.loginAccessToken`.

## ⚠️ Manejo de Errores

Todos los use cases lanzan `ApiException` en caso de error:

```dart
import 'package:menu_dart_api/core/exeptions/api_exception.dart';

try {
  final catalog = await CreateCatalogUseCase().execute(params);
} on ApiException catch (e) {
  print('Código: ${e.statusCode}');
  print('Mensaje: ${e.message}');
  
  // Errores comunes
  if (e.statusCode == 401) {
    print('No autenticado');
  } else if (e.statusCode == 404) {
    print('Catálogo no encontrado');
  } else if (e.statusCode == 403) {
    print('Sin permisos');
  }
}
```

## 🧪 Ejemplo Completo

```dart
import 'dart:typed_data';
import 'package:menu_dart_api/by_feature/catalog/data/usecase/create_catalog_usecase.dart';
import 'package:menu_dart_api/by_feature/catalog/data/usecase/get_my_catalogs_usecase.dart';
import 'package:menu_dart_api/by_feature/catalog/data/usecase/update_catalog_usecase.dart';
import 'package:menu_dart_api/by_feature/catalog/models/create_catalog_params.dart';
import 'package:menu_dart_api/by_feature/catalog/models/update_catalog_params.dart';

Future<void> catalogExample(Uint8List imageBytes) async {
  try {
    // 1. Crear catálogo
    final createParams = CreateCatalogParams(
      catalogType: 'menu',
      name: 'Pizza Restaurant',
      description: 'Las mejores pizzas de la ciudad',
      isPublic: true,
      coverImage: imageBytes,
      tags: ['pizza', 'italiano', 'restaurante'],
      metadata: {
        'cuisine': 'italian',
        'priceRange': r'$$',
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

    // 2. Listar catálogos
    final catalogs = await GetMyCatalogsUseCase().execute(type: 'menu');
    print('📋 Total de menús: ${catalogs.length}');

    // 3. Actualizar catálogo
    final updateParams = UpdateCatalogParams(
      catalogId: newCatalog.id,
      name: 'Pizza Restaurant Premium',
      status: 'active',
      metadata: {
        ...newCatalog.metadata ?? {},
        'rating': 4.5,
      },
    );

    final updated = await UpdateCatalogUseCase().execute(updateParams);
    print('✅ Catálogo actualizado: ${updated.name}');

  } catch (e) {
    print('❌ Error: $e');
  }
}
```

## 💡 Buenas Prácticas

1. **Validar datos antes de enviar**: Asegúrate de que los tipos de catálogo y estados sean válidos
2. **Manejo de imágenes**: Usa el helper `ImageSizeHelper.resizeIfNeeded()` antes de enviar imágenes
3. **Metadata y Settings**: Usa estructuras JSON simples y serializables
4. **Tags**: Mantén los tags consistentes y en minúsculas
5. **Errores**: Siempre captura `ApiException` para manejar errores específicos

---

## 🛍️ Gestión de Items en Catálogos

### 1. Crear Item en Catálogo

```dart
import 'dart:typed_data';
import 'package:menu_dart_api/by_feature/catalog/data/usecase/create_catalog_item_usecase.dart';
import 'package:menu_dart_api/by_feature/catalog/models/create_catalog_item_params.dart';

final params = CreateCatalogItemParams(
  catalogId: '550e8400-e29b-41d4-a716-446655440000',
  name: 'Pizza Margherita',
  price: 12.99,
  description: 'Pizza clásica con tomate, mozzarella y albahaca',
  discountPrice: 9.99,
  quantity: 10,
  sku: 'PIZZA-MARG-001',
  category: 'Pizzas',
  isAvailable: true,
  isFeatured: false,
  attributes: {
    'ingredients': ['tomate', 'mozzarella', 'albahaca'],
    'calories': 450,
    'spicyLevel': 0,
  },
  tags: ['vegetariana', 'clasica'],
  photo: imageBytes,
);

try {
  final item = await CreateCatalogItemUseCase().execute(params);
  print('✅ Item creado: ${item.id}');
  print('Nombre: ${item.name}');
  print('Precio: \$${item.price}');
  print('SKU: ${item.sku}');
} catch (e) {
  print('❌ Error: $e');
}
```

### 2. Obtener Item por ID

```dart
import 'package:menu_dart_api/by_feature/catalog/data/usecase/get_catalog_item_by_id_usecase.dart';

final item = await GetCatalogItemByIdUseCase().execute(
  catalogId: '550e8400-e29b-41d4-a716-446655440000',
  itemId: 'item-550e8400-e29b-41d4-a716-446655440001',
);

print('Nombre: ${item.name}');
print('Precio: \$${item.price}');
print('Descuento: \$${item.discountPrice}');
print('Stock: ${item.quantity}');
print('Disponible: ${item.isAvailable}');
print('Categoría: ${item.category}');

// Acceder a atributos personalizados
if (item.attributes != null) {
  print('Ingredientes: ${item.attributes!['ingredients']}');
  print('Calorías: ${item.attributes!['calories']}');
}
```

### 3. Actualizar Item

```dart
import 'package:menu_dart_api/by_feature/catalog/models/update_catalog_item_params.dart';
import 'package:menu_dart_api/by_feature/catalog/data/usecase/update_catalog_item_usecase.dart';

// Actualizar precio y disponibilidad
final params = UpdateCatalogItemParams(
  catalogId: '550e8400-e29b-41d4-a716-446655440000',
  itemId: 'item-550e8400-e29b-41d4-a716-446655440001',
  name: 'Pizza Margherita Premium',
  price: 14.99,
  discountPrice: 12.99,
  isAvailable: true,
  status: 'available',
);

final updated = await UpdateCatalogItemUseCase().execute(params);
print('✅ Item actualizado: ${updated.name}');

// Actualizar con nueva imagen y atributos
final paramsWithImage = UpdateCatalogItemParams(
  catalogId: '550e8400-e29b-41d4-a716-446655440000',
  itemId: 'item-550e8400-e29b-41d4-a716-446655440001',
  attributes: {
    'ingredients': ['tomate', 'mozzarella premium', 'albahaca fresca'],
    'calories': 500,
    'featured': true,
  },
  isFeatured: true,
  photo: newImageBytes,
);

await UpdateCatalogItemUseCase().execute(paramsWithImage);

// Marcar como agotado
final outOfStock = UpdateCatalogItemParams(
  catalogId: catalogId,
  itemId: itemId,
  quantity: 0,
  isAvailable: false,
  status: 'out_of_stock',
);

await UpdateCatalogItemUseCase().execute(outOfStock);
```

### 4. Eliminar Item

```dart
import 'package:menu_dart_api/by_feature/catalog/data/usecase/delete_catalog_item_usecase.dart';

final result = await DeleteCatalogItemUseCase().execute(
  catalogId: '550e8400-e29b-41d4-a716-446655440000',
  itemId: 'item-550e8400-e29b-41d4-a716-446655440001',
);

print(result['message']); // "Item eliminado exitosamente"
print(result['itemId']);
```

## 📊 Estados de Items

Valores válidos para `status`:
- `available` - Disponible
- `out_of_stock` - Agotado
- `discontinued` - Descontinuado
- `coming_soon` - Próximamente

## 🎯 Ejemplo Completo: Gestión de Menú

```dart
import 'dart:typed_data';
import 'package:menu_dart_api/by_feature/catalog/data/usecase/create_catalog_usecase.dart';
import 'package:menu_dart_api/by_feature/catalog/data/usecase/create_catalog_item_usecase.dart';
import 'package:menu_dart_api/by_feature/catalog/models/create_catalog_params.dart';
import 'package:menu_dart_api/by_feature/catalog/models/create_catalog_item_params.dart';

Future<void> createRestaurantMenu(Uint8List coverImage) async {
  try {
    // 1. Crear catálogo de menú
    final catalogParams = CreateCatalogParams(
      catalogType: 'menu',
      name: 'Menú Pizzería Italia',
      description: 'Auténticas pizzas italianas',
      isPublic: true,
      coverImage: coverImage,
      tags: ['italiano', 'pizza', 'pasta'],
      metadata: {
        'cuisine': 'italian',
        'priceRange': r'$$',
      },
      settings: {
        'allowOrders': true,
        'showPrices': true,
      },
    );

    final catalog = await CreateCatalogUseCase().execute(catalogParams);
    print('✅ Catálogo creado: ${catalog.id}');

    // 2. Agregar items al menú
    final pizzas = [
      CreateCatalogItemParams(
        catalogId: catalog.id,
        name: 'Pizza Margherita',
        price: 12.99,
        description: 'Tomate, mozzarella y albahaca',
        category: 'Pizzas',
        attributes: {'size': 'medium', 'calories': 450},
        tags: ['vegetariana'],
      ),
      CreateCatalogItemParams(
        catalogId: catalog.id,
        name: 'Pizza Pepperoni',
        price: 14.99,
        description: 'Pepperoni y mozzarella',
        category: 'Pizzas',
        attributes: {'size': 'medium', 'calories': 520},
        tags: ['clasica'],
      ),
    ];

    for (var pizzaParams in pizzas) {
      final item = await CreateCatalogItemUseCase().execute(pizzaParams);
      print('✅ Item agregado: ${item.name} - \$${item.price}');
    }

    print('🎉 Menú completo creado con ${pizzas.length} items');
  } catch (e) {
    print('❌ Error: $e');
  }
}
```

## 🔄 Integración con el Dashboard

Para usar en controladores GetX:

```dart
import 'package:get/get.dart';
import 'package:menu_dart_api/by_feature/catalog/data/usecase/get_my_catalogs_usecase.dart';
import 'package:menu_dart_api/by_feature/catalog/models/catalog_model.dart';

class CatalogController extends GetxController {
  RxList<CatalogModel> catalogs = <CatalogModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCatalogs();
  }

  Future<void> loadCatalogs() async {
    try {
      isLoading.value = true;
      catalogs.value = await GetMyCatalogsUseCase().execute();
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron cargar los catálogos');
    } finally {
      isLoading.value = false;
    }
  }
}
```
