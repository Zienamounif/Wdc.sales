import 'package:ecormmec/core/searvices/services.dart';
import 'package:ecormmec/routes.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/constans/color.dart';
import 'core/localization/changelocal.dart';
import 'core/localization/translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LogalController controller = Get.put(LogalController());
    return GetMaterialApp(
      translations: Mytranslation(),
      debugShowCheckedModeBanner: false,
      locale: controller.language,
      theme: ThemeData(
        fontFamily: "playfairDisplay",
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.black),
          headline2: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 26, color: AppColor.black),
          bodyText1: TextStyle(
              height: 2,
              color: AppColor.grey,
              fontSize: 17,
              fontWeight: FontWeight.bold),
        ),
      ),
   
      getPages:routes,
    );
  }
}
