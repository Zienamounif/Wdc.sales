import 'package:ecormmec/core/constans/color.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/orderscontroller.dart';

import '../../widget/order/showdialog.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(OrdersControllerImp());
    return GetBuilder<OrdersControllerImp>(
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.orders.isEmpty) {
          return const Center(child: Text("No orders found"));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.orders.length,
                itemBuilder: (context, index) {
                  final order = controller.orders[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header: Order status and delete button
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Status: Pending",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    bool deleted = await controller.deleteOrder(order.orderId);
                                    if (deleted) {
                                      Get.snackbar(
                                        "Success",
                                        "Order deleted successfully",
                                        duration: Duration(seconds: 2),
                                        backgroundColor: AppColor.success,
                                        colorText: Colors.white,
                                      );
                                      controller.fetchOrders(); // Refresh the order list
                                    } else {
                                      Get.snackbar(
                                        "Error",
                                        "Failed to delete order",
                                        snackPosition: SnackPosition.BOTTOM,
                                        duration: Duration(seconds: 2),
                                        backgroundColor: AppColor.error,
                                        colorText: Colors.white,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 8),

                          // List of products in the order
                          ...order.items.map((item) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(item.productId,
                                        style: TextStyle(fontSize: 15)),
                                    Text('Qty: ${item.quantity}',
                                        style: TextStyle(fontSize: 15)),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),

                          SizedBox(height: 8),

                          Text(
                            'Order date: ${order.createdAt.toLocal().toString().split(' ')[0]}',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Payment button at the bottom
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(vertical: 20),
                color: AppColor.primarycolor,
                onPressed: () {
                  showAddressDialog(context, controller);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.credit_card, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Payments",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }


}
