import 'dart:convert';

import 'package:ecormmec/core/constans/color.dart';
import 'package:ecormmec/core/constans/routes.dart';
import 'package:ecormmec/linkapi.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// import '../../data/model/authmodel.dart';
import '../../core/functions/validinput.dart';
import '../../data/model/register.dart';

abstract class SignUpController extends GetxController {
  signUP();
  goToSignIn();
}

class SignUpControllerImp extends SignUpController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController email;
  late TextEditingController password;

  bool isshowpassword = true;

  Future<void> register(RegisterInputModel model) async {
   
     final validationMessages = [
    validInput(model.firstName, 2, 20, 'firstName'),
    validInput(model.lastName, 2, 20, 'lastName'),
    validInput(model.email, 5, 50, 'email'),
    validInput(model.password, 6, 20, 'password'),
  ];

  // ابحث عن أول رسالة خطأ
  final errorMessage = validationMessages.firstWhere((msg) => msg != null, orElse: () => null);
  if (errorMessage != null) {
    Get.snackbar(
      "Validation Error",
      errorMessage,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: AppColor.error,
      colorText: Colors.white,
    );
    return; // الخروج من الدالة إذا كانت هناك أخطاء في المدخلات
  }
    final url = Uri.parse(AppLink.register);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      String message =
          jsonResponse["message"] ?? "Account created successfully";

      Get.snackbar(
        "Success",
        message,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: AppColor.success,
        colorText: Colors.white,
      );
      print(jsonResponse); // الانتقال إلى صفحة تسجيل الدخول
      Get.toNamed(Approute.login);
    } else {
      Get.snackbar(
        "Error",
        "Register falied",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: AppColor.error,
        colorText: Colors.white,
      );

      print('Login Failed: ${response.body}');
      return null;
    }
  }

  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  @override
  goToSignIn() {
    Get.offNamed(Approute.login);
  }

  @override
  signUP() {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      print("valid");
    } else {
      print("not valid");
    }
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    firstName = TextEditingController();
    lastName = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    firstName.dispose();
    lastName.dispose();
    super.dispose();
  }
}
