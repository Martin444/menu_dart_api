import 'package:menu_dart_api/by_feature/orders/models/new_order_param.dart';

class Order {
  final String? id;
  final String? customerEmail;
  final String? customerPhone;
  final String? operationID;
  final String? paymentUrl;
  final double? total;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<OrderItem>? items;

  Order({
    this.id,
    this.customerEmail,
    this.customerPhone,
    this.operationID,
    this.paymentUrl,
    this.total,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      customerEmail: json['customerEmail'],
      customerPhone: json['customerPhone'],
      operationID: json['operationID'],
      paymentUrl: json['paymentUrl'],
      total: double.tryParse(json['total'].toString()),
      status: json['status'],
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
      items: (json['items'] as List<dynamic>?)?.map((item) => OrderItem.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'id': id,
      'customerEmail': customerEmail,
      'customerPhone': customerPhone,
      'operationID': operationID,
      'paymentUrl': paymentUrl,
      'total': total,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'items': items?.map((item) => item.toJson()).toList(),
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
    String? operationID,
    String? paymentUrl,
    double? total,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<OrderItem>? items,
  }) {
    return Order(
      id: id ?? this.id,
      customerEmail: customerEmail ?? this.customerEmail,
      customerPhone: customerPhone ?? this.customerPhone,
      operationID: operationID ?? this.operationID,
      paymentUrl: paymentUrl ?? this.paymentUrl,
      total: total ?? this.total,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items,
    );
  }
}
