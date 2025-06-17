import 'package:ecormmec/core/constans/color.dart';
import 'package:ecormmec/core/constans/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/localization/changelocal.dart';
import '../widget/language/buttonlanguage.dart';

class Language extends GetView<LogalController> {
  const Language({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("1".tr,style:Theme.of(context).textTheme.headline1,),
            SizedBox(height: 20,),
            ButtonLanguage(
              textbutton: "Ar",
              onPressed: (){
               controller.changelang("ar");
               Get.toNamed(Approute.onbording);
              },
            ),
            ButtonLanguage(
              textbutton: "En",
              onPressed: (){
                controller.changelang("en");
                Get.toNamed(Approute.onbording);
              },
            )
          ],
        ),
      ),
    );
  }
}
