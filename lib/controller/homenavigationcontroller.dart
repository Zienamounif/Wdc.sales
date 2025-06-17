import 'package:ecormmec/view/screen/auth/home.dart';
import 'package:ecormmec/view/screen/view/orders.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';



abstract class HomeNavigationController extends GetxController{
 changepage(int i);
}
class HomeNavigationControllerImp extends HomeNavigationController{
  int cureentpage=0;
  List<Widget> listpages=[
    const Home(),
    const Orders(),
  ];
  @override
  changepage(int i) {
     cureentpage=i;
     update();
  }



}