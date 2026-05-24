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
  final double? subtotal;
  final double? marketplaceFeePercentage;
  final double? marketplaceFeeAmount;
  final double? mpProcessingFee;
  final double? netAmount;
  final String? status;
  final String? paymentStatus;
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
    this.subtotal,
    this.marketplaceFeePercentage,
    this.marketplaceFeeAmount,
    this.mpProcessingFee,
    this.netAmount,
    this.status,
    this.paymentStatus,
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
      subtotal: double.tryParse(json['subtotal']?.toString() ?? ''),
      marketplaceFeePercentage: double.tryParse(json['marketplaceFeePercentage']?.toString() ?? ''),
      marketplaceFeeAmount: double.tryParse(json['marketplaceFeeAmount']?.toString() ?? ''),
      mpProcessingFee: json['mpProcessingFee'] != null ? double.tryParse(json['mpProcessingFee'].toString()) : null,
      netAmount: json['netAmount'] != null ? double.tryParse(json['netAmount'].toString()) : null,
      status: json['status']?.toString(),
      paymentStatus: json['paymentStatus']?.toString(),
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
      'subtotal': subtotal,
      'marketplaceFeePercentage': marketplaceFeePercentage,
      'marketplaceFeeAmount': marketplaceFeeAmount,
      'mpProcessingFee': mpProcessingFee,
      'netAmount': netAmount,
      'status': status,
      'paymentStatus': paymentStatus,
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
    double? subtotal,
    double? marketplaceFeePercentage,
    double? marketplaceFeeAmount,
    double? mpProcessingFee,
    double? netAmount,
    String? status,
    String? paymentStatus,
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
      subtotal: subtotal ?? this.subtotal,
      marketplaceFeePercentage: marketplaceFeePercentage ?? this.marketplaceFeePercentage,
      marketplaceFeeAmount: marketplaceFeeAmount ?? this.marketplaceFeeAmount,
      mpProcessingFee: mpProcessingFee ?? this.mpProcessingFee,
      netAmount: netAmount ?? this.netAmount,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

