import 'package:menu_dart_api/by_feature/orders/models/new_order_param.dart';

class Order {
  final String? id;
  final String? customerEmail;
  final String? customerPhone;
  final String? customerName;
  final String? customerLastName;
  final String? createdBy;
  final String? ownerId;
  final String? operationID;
  final String? paymentUrl;
  final List<OrderItem>? items;
  final double? total;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Order({
    this.id,
    this.customerEmail,
    this.customerPhone,
    this.customerName,
    this.customerLastName,
    this.createdBy,
    this.ownerId,
    this.operationID,
    this.paymentUrl,
    this.items,
    this.total,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    List<OrderItem> itemsList = [];
    if (json['items'] != null && json['items'] is List) {
      itemsList = (json['items'] as List)
          .map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return Order(
      id: json['id']?.toString(),
      customerEmail: json['customerEmail']?.toString(),
      customerPhone: json['customerPhone']?.toString(),
      customerName: json['customerName']?.toString(),
      customerLastName: json['customerLastName']?.toString(),
      createdBy: json['createdBy']?.toString(),
      ownerId: json['ownerId']?.toString(),
      operationID: json['operationID']?.toString(),
      paymentUrl: json['paymentUrl']?.toString(),
      items: itemsList,
      total: double.tryParse(json['total']?.toString() ?? '0') ?? 0.0,
      status: json['status']?.toString(),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'id': id,
      'customerEmail': customerEmail,
      'customerPhone': customerPhone,
      'customerName': customerName,
      'customerLastName': customerLastName,
      'createdBy': createdBy,
      'ownerId': ownerId,
      'operationID': operationID,
      'paymentUrl': paymentUrl,
      'items': items?.map((item) => item.toJson()).toList(),
      'total': total,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
    data.removeWhere((key, value) => value == null);
    return data;
  }
}

extension OrderCopyWith on Order {
  Order copyWith({
    String? id,
    String? customerEmail,
    String? customerPhone,
    String? customerName,
    String? customerLastName,
    String? createdBy,
    String? ownerId,
    String? operationID,
    String? paymentUrl,
    List<OrderItem>? items,
    double? total,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Order(
      id: id ?? this.id,
      customerEmail: customerEmail ?? this.customerEmail,
      customerPhone: customerPhone ?? this.customerPhone,
      customerName: customerName ?? this.customerName,
      customerLastName: customerLastName ?? this.customerLastName,
      createdBy: createdBy ?? this.createdBy,
      ownerId: ownerId ?? this.ownerId,
      operationID: operationID ?? this.operationID,
      paymentUrl: paymentUrl ?? this.paymentUrl,
      items: items ?? this.items,
      total: total ?? this.total,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

