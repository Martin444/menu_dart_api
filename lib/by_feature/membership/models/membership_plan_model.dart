/// Modelo que representa un plan de membresía disponible
class MembershipPlanModel {
  final String? id;
  final String name;
  final String? description;
  final double price;
  final String currency;
  final List<String> features;
  final int? maxItems;
  final int? maxCatalogs;
  final bool isActive;

  MembershipPlanModel({
    this.id,
    required this.name,
    this.description,
    this.price = 0.0,
    this.currency = 'ARS',
    this.features = const [],
    this.maxItems,
    this.maxCatalogs,
    this.isActive = true,
  });

  factory MembershipPlanModel.fromJson(Map<String, dynamic> json) {
    return MembershipPlanModel(
      id: json['id']?.toString(),
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString(),
      price: (json['price'] ?? 0).toDouble(),
      currency: json['currency']?.toString() ?? 'ARS',
      features: json['features'] != null
          ? (json['features'] as List).map((e) => e.toString()).toList()
          : [],
      maxItems: json['maxItems'] as int?,
      maxCatalogs: json['maxCatalogs'] as int?,
      isActive: json['isActive'] ?? json['active'] ?? ! (json['isArchived'] ?? false),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'currency': currency,
      'features': features,
      'maxItems': maxItems,
      'maxCatalogs': maxCatalogs,
      'isActive': isActive,
    };
  }
}

