import 'dart:math';

import 'package:ecormmec/controller/auth/homepageController.dart';

import 'package:ecormmec/core/constans/color.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/home/showQuantityDialog.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
  

    final List<String> productImages = [
      'images/product1.jpg',
      'images/product2.jpg',
      'images/product3.jpg',
    ];
    return GetBuilder<HomeControllerImp>(
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
         if (controller.products.isEmpty) {
          return const Center(child: Text("No products found"));
        }

        final random = Random();

        return ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            final randomImage = productImages[random.nextInt(productImages.length)];

            return Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // صورة المنتج
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(randomImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(Icons.shopping_cart),
                          label: Text('Add to Cart'),
                          style: ElevatedButton.styleFrom(
                            primary: AppColor.primarycolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: (){

                                  showQuantityDialog(context, product, controller); // استدعاء الديالوج الجديد
  
                          },
                        ),
                        SizedBox(width: 20),
                        Container(
                        padding: EdgeInsets.all(5),
                       
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.primarycolor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Qt : " ,style:const TextStyle(fontSize: 12,fontWeight:FontWeight.bold),),
                               Text(
                                  product.quantity.toString(),
                                  style: const TextStyle(fontSize: 15),
                                ),

                           
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

}