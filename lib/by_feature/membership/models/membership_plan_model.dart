/// Modelo que representa un plan de membresía disponible
class MembershipPlanModel {
  final String? id;
  final String name;
  final String? displayName;
  final String? description;
  final double price;
  final String currency;
  final List<String> features;
  final MembershipPlanLimits limits;
  final bool isActive;
  final bool isDefault;

  MembershipPlanModel({
    this.id,
    required this.name,
    this.displayName,
    this.description,
    this.price = 0.0,
    this.currency = 'ARS',
    this.features = const [],
    MembershipPlanLimits? limits,
    this.isActive = true,
    this.isDefault = false,
  }) : limits = limits ?? MembershipPlanLimits();

  factory MembershipPlanModel.fromJson(Map<String, dynamic> json) {
    return MembershipPlanModel(
      id: json['id']?.toString() ?? json['_id']?.toString(),
      name: json['name']?.toString() ?? '',
      displayName: json['displayName']?.toString(),
      description: json['description']?.toString(),
      price: json['price'] != null
          ? double.tryParse(json['price'].toString()) ?? 0.0
          : 0.0,
      currency: json['currency']?.toString() ?? 'ARS',
      features: json['features'] != null
          ? (json['features'] as List).map((e) => e.toString()).toList()
          : [],
      limits: json['limits'] != null
          ? MembershipPlanLimits.fromJson(json['limits'] as Map<String, dynamic>)
          : MembershipPlanLimits(),
      isActive: json['isActive'] ?? (json['status'] == 'active'),
      isDefault: json['isDefault'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'displayName': displayName ?? name,
      'description': description,
      'price': price,
      'currency': currency,
      'features': features,
      'limits': limits.toJson(),
      'isActive': isActive,
      'isDefault': isDefault,
    };
  }
}

class MembershipPlanLimits {
  final int maxCommerces;
  final int maxCatalogs;
  final int maxCatalogItems;
  final int maxLocations;
  final int analyticsRetention;
  final int maxUsers;
  final int maxApiCalls;
  final int storageLimit;

  MembershipPlanLimits({
    this.maxCommerces = 1,
    this.maxCatalogs = 1,
    this.maxCatalogItems = 10,
    this.maxLocations = 1,
    this.analyticsRetention = 7,
    this.maxUsers = 1,
    this.maxApiCalls = 100,
    this.storageLimit = 100,
  });

  factory MembershipPlanLimits.fromJson(Map<String, dynamic> json) {
    return MembershipPlanLimits(
      maxCommerces: json['maxCommerces'] as int? ?? 1,
      maxCatalogs: json['maxCatalogs'] as int? ?? 1,
      maxCatalogItems: json['maxCatalogItems'] as int? ?? 10,
      maxLocations: json['maxLocations'] as int? ?? 1,
      analyticsRetention: json['analyticsRetention'] as int? ?? 7,
      maxUsers: json['maxUsers'] as int? ?? 1,
      maxApiCalls: json['maxApiCalls'] as int? ?? 100,
      storageLimit: json['storageLimit'] as int? ?? 100,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maxCommerces': maxCommerces,
      'maxCatalogs': maxCatalogs,
      'maxCatalogItems': maxCatalogItems,
      'maxLocations': maxLocations,
      'analyticsRetention': analyticsRetention,
      'maxUsers': maxUsers,
      'maxApiCalls': maxApiCalls,
      'storageLimit': storageLimit,
    };
  }
}
