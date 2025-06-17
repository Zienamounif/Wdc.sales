import 'dart:convert';

import 'package:ecormmec/core/constans/routes.dart';
import 'package:ecormmec/linkapi.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:get/get.dart';


import '../../core/constans/color.dart';
import '../../core/searvices/services.dart';
import '../../data/model/authmodel.dart';

// import '../../data/model/authmodel.dart';
// import '../../data/model/login.dart';

abstract class LoginController extends GetxController {
  // login();
  goToSignUp();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;
  Myservices myservices = Get.find();


  Future<AuthModel?> loginmethod(String email, String password) async {
    final url = Uri.parse(AppLink.login);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);

      final auth = AuthModel.fromJson(jsonResponse);

      if (auth.token != null) {
        final prefs = myservices.sharedPreferences;
        await prefs.setString('token', auth.token!);
      }
      Get.snackbar(
        "Success",
        "Login Successfully",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: AppColor.success,
        colorText: Colors.white,
      );
      Get.toNamed(Approute.home);
      return auth;
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

  bool isshowpassword = true;

  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  @override
  goToSignUp() {
    Get.toNamed(Approute.signup);
  }



  @override
  void onInit() async {
    final prefs = myservices.sharedPreferences;
    String? token = prefs.getString('token');
    if (token != null) {
      Get.toNamed(Approute.home);
    } else {
    email = TextEditingController();
    password = TextEditingController();
    }
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
