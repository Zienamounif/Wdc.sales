import 'package:ecormmec/controller/homenavigationcontroller.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controller/orderscontroller.dart';

class HomeNavigation extends StatelessWidget {
  const HomeNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeNavigationControllerImp());
     Get.put(OrdersControllerImp()); 
    return GetBuilder<HomeNavigationControllerImp>(
        builder: (controller) => Scaffold(
              
              bottomNavigationBar: BottomAppBar(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            controller.changepage(0);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [Icon(Icons.home_outlined), Text("Home")],
                          ),
                        ),
                        Spacer(),
                        MaterialButton(
                          onPressed: () {
                            controller.changepage(1);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.shopping_bag_outlined),
                              Text("Orders")
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
              body: controller.listpages.elementAt(controller.cureentpage),
            ));
  }
}
