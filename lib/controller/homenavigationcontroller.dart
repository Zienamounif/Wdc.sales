import 'package:ecormmec/controller/orderscontroller.dart';
import 'package:ecormmec/view/screen/auth/home.dart';
import 'package:ecormmec/view/screen/view/orders.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../core/constans/color.dart';
import 'auth/homepageController.dart';

abstract class HomeNavigationController extends GetxController {
  changepage(int i);
}

class HomeNavigationControllerImp extends HomeNavigationController {
  int cureentpage = 0;
  List<Widget> listpages = [
    const Home(),
    const Orders(),
  ];
  @override
  changepage(int i) async {
    if (i == 1) {
      // الحصول على الكنترولر الخاص بالمنتجات
      HomeControllerImp homeController = Get.find();
       OrdersControllerImp ordersController = Get.find();

      if (homeController.cartItems.isNotEmpty) {
        bool success = await homeController.createOrder();
        if (!success) return;
      }


      if (homeController.cartItems.isEmpty &&
          ordersController.orders.isNotEmpty) {
        cureentpage = i;
        update();
        return;
      }
   
    }

    cureentpage = i;
    update();
  }
}
