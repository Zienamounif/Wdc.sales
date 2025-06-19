
class Product {
  final String id;
  final int quantity;
  final double price;
  final int sequence;
 

 

  Product({
    required this.id,
    required this.quantity,
    required this.price,
    required this.sequence,
      
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      sequence: json['sequence'],
    );
  }

  
 
}
