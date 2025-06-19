import 'dart:convert';

import 'package:ecormmec/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../core/constans/color.dart';
import '../../core/searvices/services.dart';
import 'package:http/http.dart' as http;

import '../../data/model/order.dart';
import '../../data/model/prouduct.dart';
import '../orderscontroller.dart';

abstract class HomeController extends GetxController {}

class HomeControllerImp extends HomeController {
  Myservices myservices = Get.find();
  List<Product> products = [];
  bool isLoading = true;
  List<OrderItem> cartItems = [];
 OrdersControllerImp ordersController = Get.find();

  void fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(AppLink.products));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        products = data.map((item) => Product.fromJson(item)).toList();
        isLoading = false;
        update(); // تنبيه GetX لتحديث الواجهة
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print("Error fetching products: $e");
      isLoading = false;
      update();
    }
  }

  void addToCart(Product product, int quantity) {
    int index = cartItems.indexWhere((item) => item.productId == product.id);

    if (index == -1) {
      cartItems.add(OrderItem(
        productId: product.id,
        quantity: quantity,
      ));
    } else {
      cartItems[index] = OrderItem(
        productId: product.id,
        quantity: quantity,
      );
    }
    update();
    Get.snackbar(
      "Success",
      "Product added To Order successfully Qt:${quantity}",
      duration: Duration(seconds: 2),
      backgroundColor: AppColor.success,
      colorText: Colors.white,
    );
  }

  Future<bool> createOrder() async {
    if (cartItems.isEmpty) {
      Get.snackbar("Cart Empty", "Please add products before ordering");
      return false;
    }

    final prefs = myservices.sharedPreferences;
    String? token = prefs.getString('token');

    final url = Uri.parse(AppLink.addOrder);
    final items = cartItems.map((item) => item.toJson()).toList();

    final requestBody = jsonEncode({"items": items});

    try {
      print("aaaaaaaaaaaaaaaaaaaaa");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
      
        update();
        final jsonResponse = jsonDecode(response.body);
         cartItems.clear();
         update();
         await ordersController.fetchOrders();  // لجلب الطلبات الجديدة
         ordersController.update();  
        Get.snackbar(
          "Success",
          "Order added successfully",
          duration: Duration(seconds: 2),
          backgroundColor: AppColor.success,
          colorText: Colors.white,
        );
        
        return true;
      } else {
        Get.snackbar(
          "Error",
          "Failed to create order: ${response.statusCode}",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          backgroundColor: AppColor.error,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred");
      return false;
    }
  }

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }
}
