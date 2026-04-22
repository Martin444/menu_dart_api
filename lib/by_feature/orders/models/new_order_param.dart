class NewOrderParam {
  final String? customerId;
  final String? customerEmail;
  final String? customerPhone;
  final String? customerName;
  final String? customerLastName;
  final String? ownerId;
  final double total;
  final String? status;
  final List<OrderItem> items;

  NewOrderParam({
    this.customerId,
    this.customerEmail,
    this.customerPhone,
    this.customerName,
    this.customerLastName,
    this.ownerId,
    required this.total,
    this.status,
    required this.items,
  });

  factory NewOrderParam.fromJson(Map<String, dynamic> json) {
    return NewOrderParam(
      customerId: json['customerId'],
      customerEmail: json['customerEmail'],
      customerPhone: json['customerPhone'],
      customerName: json['customerName'],
      customerLastName: json['customerLastName'],
      ownerId: json['ownerId'],
      total: (json['total'] as num).toDouble(),
      status: json['status'],
      items: (json['items'] as List).map((item) => OrderItem.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'customerId': customerId,
      'customerEmail': customerEmail,
      'customerPhone': customerPhone,
      'customerName': customerName,
      'customerLastName': customerLastName,
      'ownerId': ownerId,
      'total': total,
      'status': status,
      'items': items.map((item) => item.toJson()).toList(),
    };
    data.removeWhere((key, value) => value == null);
    return data;
  }
}

class OrderItem {
  final String productName;
  final int quantity;
  final double price;
  final String sourceId;
  final String sourceType;

  OrderItem({
    required this.productName,
    required this.quantity,
    required this.price,
    required this.sourceId,
    required this.sourceType,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productName: json['productName'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
      sourceId: json['sourceId'] ?? '',
      sourceType: json['sourceType'] ?? 'menu',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'quantity': quantity,
      'price': price,
      'sourceId': sourceId,
      'sourceType': sourceType,
    };
  }
}

