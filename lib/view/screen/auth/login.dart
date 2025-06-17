import 'package:ecormmec/controller/auth/logincontroller.dart';
import 'package:ecormmec/core/constans/color.dart';
import 'package:ecormmec/core/functions/validinput.dart';

import 'package:ecormmec/view/widget/auth/TextBodyAuth.dart';
import 'package:ecormmec/view/widget/auth/TextTittleAuth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../../core/constans/imageasset.dart';
import '../../../data/model/login.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/logoimage.dart';
import '../../widget/auth/textformauth.dart';
import '../../widget/auth/textsignup.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginControllerImp controller = Get.put(LoginControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.background,
        elevation: 0.0,
        title: Text("Sign in",
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: AppColor.grey)),
      ),
      body:
          Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Form(
                key: controller.formstate,
                child: ListView(
                  children: [
                    Logo(),
                    const TextTittleAuth(
                      text: "Welcom Back",
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    const TextBodyAuth(
                      text: "sign in with your email and password ",
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    TextFormAuth(
                      valid: (val) {
                        return validInput(val!, 5, 100, "email");
                      },
                      mycontroller: controller.email,
                      hinttext: "Enter your Email",
                      iconedata: Icons.email_outlined,
                      labeltext: "Email",
                    ),

                    GetBuilder<LoginControllerImp>(
                      builder: (controller) => TextFormAuth(
                          valid: (val) {
                            return validInput(val!, 5, 20, "password");
                          },
                          obscuretext: controller.isshowpassword,
                          onTapIcon: () {
                            controller.showPassword();
                          },
                          mycontroller: controller.password,
                          hinttext: "Enter your password",
                          labeltext: "Password",
                          iconedata: Icons.lock_outline),
                    ),
                    CustomButtonAuth(
                      text: "Sign In",
                      onPressed: () {
                        // controller.login();
                        // LoginInputModel loginInput = LoginInputModel(
                        //   email: controller.email.text,
                        //   password: controller.password.text,
                        // );
                         controller.loginmethod(controller.email.text, controller.password.text);
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomTestSignUporSignIn(
                      text1: "Dont have an account ?",
                      text2: "Sign Up",
                      onTap: () {
                        controller.goToSignUp();
                      },
                    )
                    // mycontroller: ,
                  ],
                ),
              )),
      
    );
  }
}
