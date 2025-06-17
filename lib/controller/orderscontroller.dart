import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constans/color.dart';
import '../core/constans/routes.dart';
import '../core/searvices/services.dart';
import '../data/model/order.dart';

import 'package:http/http.dart' as http;

import '../linkapi.dart';


abstract class OrdersController extends GetxController {}

class OrdersControllerImp extends GetxController {
  List<OrderItem> cartItems = [];
  List<Order> orders = [];
  bool isLoading = false;
  Myservices myservices = Get.find();

  /// جلب كل الطلبات الخاصة بالمستخدم
  Future<void> fetchOrders() async {
    try {
      final prefs = myservices.sharedPreferences;
      String? token = prefs.getString('token');
      final response = await http.get(
        Uri.parse(AppLink.getOrders), // API URL
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> ordersData =
            jsonResponse["getAllOrderOutPutModels"];
        print(jsonResponse);
        orders = ordersData.map((json) => Order.fromJson(json)).toList();
        isLoading = false;
        update();
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      print("Error fetching orders: $e");
      isLoading = false;
      update();
    }
  }

  Future<bool> deleteOrder(String orderId) async {
    final prefs = myservices.sharedPreferences;
    String? token = prefs.getString('token');

    try {
      final url = Uri.parse(AppLink.deleteOrder((orderId)));
      print("bbbbbbbbbbb");
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        print("aaaaaaaaaaaaaaaa");
        update();
        return true;
      } else {
        print('فشل الحذف، رمز الحالة: ${response.statusCode}');

        return false;
      }
    } catch (e) {
      print('حدث خطأ أثناء محاولة الحذف: $e');

      return false;
    }
  }

Future<void> pay(String address, BuildContext context) async {
  isLoading = true;
  update();
  final prefs = myservices.sharedPreferences;
  String? token = prefs.getString('token');
  bool allSuccess = true;

  try {
    for (var order in orders) {
      final response = await http.post(
        Uri.parse(AppLink.payments), // عدل إلى رابطك الصحيح
        headers: {
          "Content-Type": "application/json",
           'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "locationName": address,
          "orderId": order.orderId,
          "reduceBalanceWallets": order.items.map((item) => {
                "productId": item.productId,
                "quantity": item.quantity,
              }).toList(),
        }),
      );

      if (response.statusCode != 200) {
        allSuccess = false;
        Get.snackbar(
          "Error",
          "فشل الدفع للطلب رقم ${order.orderId}",
          backgroundColor: AppColor.error,
          colorText: Colors.white,
        );
        break; // توقف عند أول فشل
      }
    }

    if (allSuccess) {
         Get.snackbar(
          "Success",
          " Payment completed successfully",
          backgroundColor: AppColor.success,
          colorText: Colors.white,
        );
      Get.offAllNamed(Approute.home);
    }
  } catch (e) {
    Get.snackbar("Error", "Something went wrong $e",
        backgroundColor: AppColor.error, colorText: Colors.white);
  } finally {
    isLoading = false;
    update();
  }
}


  @override
  void onInit() {
    fetchOrders();
    super.onInit();
  }
}
