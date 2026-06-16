enum CommerceCategory {
  retail,
  food,
  wardrobe,
  services,
  wholesale,
}

enum BusinessContext {
  general,
  restaurant,
  wardrobe,
  marketplace,
  events,
}

class TypeCommerceModel {
  String id;
  String code;
  String description;
  CommerceCategory category;
  BusinessContext backendContext;

  TypeCommerceModel({
    required this.id,
    required this.code,
    required this.description,
    required this.category,
    required this.backendContext,
  });

  static List<TypeCommerceModel> getAvailableCommerceTypes() {
    return [
      TypeCommerceModel(
        id: '1',
        code: 'retail',
        description: 'Venta de productos general',
        category: CommerceCategory.retail,
        backendContext: BusinessContext.marketplace,
      ),
      TypeCommerceModel(
        id: '2',
        code: 'water_distributor',
        description: 'Distribuidora de agua',
        category: CommerceCategory.wholesale,
        backendContext: BusinessContext.marketplace,
      ),
      TypeCommerceModel(
        id: '3',
        code: 'grocery',
        description: 'Distribuidora de alimentos',
        category: CommerceCategory.wholesale,
        backendContext: BusinessContext.marketplace,
      ),
      TypeCommerceModel(
        id: '4',
        code: 'food',
        description: 'Restaurant/Comida',
        category: CommerceCategory.food,
        backendContext: BusinessContext.restaurant,
      ),
      TypeCommerceModel(
        id: '5',
        code: 'clothes',
        description: 'Venta de ropa',
        category: CommerceCategory.wardrobe,
        backendContext: BusinessContext.wardrobe,
      ),
      TypeCommerceModel(
        id: '6',
        code: 'accessories',
        description: 'Accesorios',
        category: CommerceCategory.retail,
        backendContext: BusinessContext.marketplace,
      ),
      TypeCommerceModel(
        id: '7',
        code: 'electronics',
        description: 'Electrónica',
        category: CommerceCategory.retail,
        backendContext: BusinessContext.marketplace,
      ),
      TypeCommerceModel(
        id: '8',
        code: 'pharmacy',
        description: 'Farmacia',
        category: CommerceCategory.services,
        backendContext: BusinessContext.general,
      ),
      TypeCommerceModel(
        id: '9',
        code: 'beauty',
        description: 'Belleza',
        category: CommerceCategory.services,
        backendContext: BusinessContext.general,
      ),
      TypeCommerceModel(
        id: '10',
        code: 'construction',
        description: 'Materiales de construcción',
        category: CommerceCategory.wholesale,
        backendContext: BusinessContext.marketplace,
      ),
      TypeCommerceModel(
        id: '11',
        code: 'automotive',
        description: 'Automotriz',
        category: CommerceCategory.services,
        backendContext: BusinessContext.general,
      ),
      TypeCommerceModel(
        id: '12',
        code: 'pets',
        description: 'Petshop',
        category: CommerceCategory.retail,
        backendContext: BusinessContext.marketplace,
      ),
      TypeCommerceModel(
        id: '13',
        code: 'events',
        description: 'Organizador de eventos',
        category: CommerceCategory.services,
        backendContext: BusinessContext.events,
      ),
    ];
  }

}
