class NewOrderParam {
  final int id;
  final String customerId;
  final String customerEmail;
  final double total;
  final String status;
  final List<OrderItem> items;

  NewOrderParam({
    required this.id,
    required this.customerId,
    required this.customerEmail,
    required this.total,
    required this.status,
    required this.items,
  });

  factory NewOrderParam.fromJson(Map<String, dynamic> json) {
    return NewOrderParam(
      id: json['id'],
      customerId: json['customerId'],
      customerEmail: json['customerEmail'],
      total: (json['total'] as num).toDouble(),
      status: json['status'],
      items: (json['items'] as List).map((item) => OrderItem.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'customerEmail': customerEmail,
      'total': total,
      'status': status,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class OrderItem {
  final String productName;
  final int quantity;
  final double price;

  OrderItem({
    required this.productName,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productName: json['productName'],
      quantity: json['quantity'],
      price: double.tryParse(json['price']) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'quantity': quantity,
      'price': price,
    };
  }
}
