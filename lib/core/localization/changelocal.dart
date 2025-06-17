import 'package:ecormmec/core/searvices/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LogalController extends GetxController{

  Locale? language ;

  Myservices myservices = Get.find();
  changelang(String langcode){
    Locale locale=Locale(langcode);
    myservices.sharedPreferences.setString("lang", langcode);
    Get.updateLocale(locale);
  }


    @override
  void onInit() {
    String? sharedlang=myservices.sharedPreferences.getString("lang");
     if(sharedlang == "ar"){
      language = const Locale("ar");
     }
     else  if (sharedlang =="en"){
      language =  const Locale("en");
     }
     else{
      language = Locale(Get.deviceLocale!.languageCode);
     }
    super.onInit();
  }
}