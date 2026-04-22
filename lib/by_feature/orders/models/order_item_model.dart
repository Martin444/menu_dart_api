class OrderItemModel {
  final int id;
  final String productName;
  final int quantity;
  final double price;

  OrderItemModel({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      productName: json['productName'],
      quantity: json['quantity'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'quantity': quantity,
      'price': price,
    };
  }
}
