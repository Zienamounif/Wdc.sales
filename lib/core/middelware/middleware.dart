import 'package:ecormmec/core/constans/routes.dart';
import 'package:ecormmec/core/searvices/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Middleware extends GetMiddleware{

  int? get Priority =>1;

  Myservices myservices= Get.find();
   RouteSettings? redirect(String? route){
  if(myservices.sharedPreferences.getString("token")!=null){
    return RouteSettings(name:Approute.login);
  }
}
}