
import 'package:ecormmec/controller/auth/homepageController.dart';
import 'package:flutter/material.dart';
import 'package:ecormmec/core/constans/color.dart';



import '../../../data/model/prouduct.dart';

void showQuantityDialog(BuildContext context, Product product, HomeControllerImp controller) {
  final TextEditingController quantityController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Enter Quantity "),
        content: TextField(
          controller: quantityController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: "Ex: 3"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              int? quantity = int.tryParse(quantityController.text);
              if (quantity != null && quantity > 0) {
                controller.addToCart(product, quantity); // تمرير الكمية للكنترولر
                Navigator.of(context).pop();
              } else {
                // عرض تنبيه في حال كانت الكمية غير صحيحة
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please Enter Valied value"),
                    backgroundColor: AppColor.error,
                  ),
                );
              }
            },
            child: Text("confirm"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("cancel", style: TextStyle(color: AppColor.primarycolor)),
          ),
        ],
      );
    },
  );
}