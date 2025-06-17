import 'dart:convert';

import 'package:ecormmec/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constans/color.dart';
import '../../core/searvices/services.dart';
import 'package:http/http.dart' as http;

import '../../data/model/order.dart';
import '../../data/model/prouduct.dart';

abstract class HomeController extends GetxController {}

class HomeControllerImp extends HomeController {
  Myservices myservices = Get.find();
  List<Product> products = [];
  bool isLoading = true;
  List<OrderItem> cartItems = [];

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

  void increaseQuantity(int index) {
    products[index].selectedQuantity++;
    update();
  // حفظ الكميات بعد التعديل
  }

  void decreaseQuantity(int index) {
    if (products[index].selectedQuantity > 1) {
      products[index].selectedQuantity--;
      update();
     // حفظ الكميات بعد التعديل
    }
  }
  
  
  void resetQuantity(int index) {
    products[index].quantity = 10;
    update();
  }

  // Future<void> saveQuantities() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   // نحفظ في SharedPreferences كـ Map<String, int> عبر تحويله لـ JSON string
  //   Map<String, int> quantitiesMap = {
  //     for (var product in products) product.id: product.quantity
  //   };

  //   await prefs.setString('product_quantities', json.encode(quantitiesMap));
  // }

  // // استرجاع الكميات من SharedPreferences
  // Future<void> loadQuantities() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? jsonString = prefs.getString('product_quantities');

  //   if (jsonString != null) {
  //     Map<String, dynamic> quantitiesMap = json.decode(jsonString);

  //     // عدل الكميات في قائمة المنتجات حسب القيم المخزنة
  //     for (var product in products) {
  //       if (quantitiesMap.containsKey(product.id)) {
  //         product.quantity = quantitiesMap[product.id];
  //       }
  //     }
  //      update(); 
  //   }
  // }

  /// إضافة منتج للسلة (cart)

  void addToCart(Product product) async {
    int index = cartItems.indexWhere((item) => item.productId == product.id);
   if (index == -1) {
    cartItems.add(OrderItem(
      productId: product.id,
      quantity: product.selectedQuantity,
    ));
  } else {
    cartItems[index] = OrderItem(
      productId: product.id,
      quantity: product.selectedQuantity,
    );
  }

    product.selectedQuantity = 10; 
    update();
    await createOrder();
  }

  Future<void> createOrder() async {
    final prefs = myservices.sharedPreferences;
    String? token = prefs.getString('token');
    
    final url = Uri.parse('http://wdcgateway.runasp.net/orders/create');
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
         cartItems.clear(); 
        update();
        final jsonResponse = jsonDecode(response.body);
        String orderId = jsonResponse["id"];
        Get.snackbar(
          "Success",
          "Order added successfully",
          duration: Duration(seconds: 2),
          backgroundColor: AppColor.success,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          "Failed to create order: ${response.statusCode}",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          backgroundColor: AppColor.error,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred");
    }
  }

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }
}
