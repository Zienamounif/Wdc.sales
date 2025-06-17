import 'package:flutter/material.dart';


import '../../../data/model/prouduct.dart';
 // تأكد من استيراد نموذج المنتج الخاص بك.

Widget buildProductItem(BuildContext context, Product product, int index) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            product.id,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 20),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              // تنفيذ الكود الخاص بحذف العنصر هنا
            },
          ),
        ],
      ),
    ),
  );
}