class OrderItem {
  final String productId;
  final int quantity;

  OrderItem({
    required this.productId,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'quantity': quantity,
  };
}

class Order {
  final String orderId;
  final String status;
  final DateTime createdAt;
  final List<OrderItem> items;

  Order({
    required this.orderId,
    required this.status,
    required this.createdAt,
    required this.items,
  });

 
  factory Order.fromJson(Map<String, dynamic> json) {
    var itemsFromJson = json['orderItemOutPutModels'] as List;
    List<OrderItem> orderItems = itemsFromJson.map((item) => OrderItem.fromJson(item)).toList();

    return Order(
      orderId: json['orderId'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      items: orderItems,
    );
  }
}

