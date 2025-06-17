
class Product {
  final String id;
   int quantity;
  final double price;
  final int sequence;
 

   int selectedQuantity;

  Product({
    required this.id,
    required this.quantity,
    required this.price,
    required this.sequence,
      this.selectedQuantity = 10,
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
