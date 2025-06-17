import 'package:ecormmec/data/model/order.dart';

class AddOrderRequest {
  final List<OrderItem> items;

  AddOrderRequest({required this.items});

  Map<String, dynamic> toJson() => {
    'items': items.map((item) => item.toJson()).toList(),
  };
}
