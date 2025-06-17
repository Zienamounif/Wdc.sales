 import 'package:flutter/material.dart';
import 'package:ecormmec/core/constans/color.dart';
import '../../../controller/orderscontroller.dart';
 void showAddressDialog(BuildContext context, OrdersControllerImp controller) {
    final TextEditingController addressController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Address"),
          content: TextField(
            controller: addressController,
            decoration: InputDecoration(hintText: "Your address"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.pay(addressController.text, context);

    
              },
              child: Text("Confirm"),
            ),
            TextButton(
              onPressed: () {
            
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color:AppColor.primarycolor),),
            ),
          ],
        );
      
      },
    );
  }