import 'package:ecormmec/controller/auth/signupcontroller.dart';
import 'package:ecormmec/core/constans/color.dart';
import 'package:ecormmec/data/model/register.dart';

import 'package:ecormmec/view/widget/auth/TextBodyAuth.dart';
import 'package:ecormmec/view/widget/auth/TextTittleAuth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/functions/validinput.dart';
import '../../widget/auth/custombuttonauth.dart';
import '../../widget/auth/textformauth.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpControllerImp controllerImp = Get.put(SignUpControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.background,
        elevation: 0.0,
        title: Text("Sign Up",
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: AppColor.grey)),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Form(
            key: controllerImp.formstate,
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                const TextTittleAuth(
                  text: "Welcom Back",
                ),
                SizedBox(
                  height: 5,
                ),
                const TextBodyAuth(
                  text: "sign Up with your email and password ",
                ),
                SizedBox(
                  height: 70,
                ),
                TextFormAuth(
                  valid: (val) {
                    return validInput(val!, 3, 100, "name");
                  },
                  mycontroller: controllerImp.firstName,
                  hinttext: "Enter your First Name",
                  iconedata: Icons.person_outline,
                  labeltext: "First Name",
                ),
                TextFormAuth(
                  valid: (val) {
                    return validInput(val!, 3, 100, "name");
                  },
                  mycontroller: controllerImp.lastName,
                  hinttext: "Enter your Last Name",
                  iconedata: Icons.person_outline,
                  labeltext: " Last Name",
                ),
                TextFormAuth(
                  valid: (val) {
                    return validInput(val!, 5, 100, "email");
                  },
                  mycontroller: controllerImp.email,
                  hinttext: "Enter your Email",
                  iconedata: Icons.email_outlined,
                  labeltext: "Email",
                ),

                GetBuilder<SignUpControllerImp>(
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
                  text: "Sign Up",
                  onPressed: ()async {
                 
                    RegisterInputModel register = RegisterInputModel(
                          firstName: controllerImp.firstName.text,
                           lastName: controllerImp.lastName.text,
                           email: controllerImp.email.text,
                           password: controllerImp.password.text,
                          );
                   await controllerImp.register(register);
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(" have an account ? "),
                    InkWell(
                      onTap: () async {
                        
                        controllerImp.goToSignIn();        },
                      child: Text("Sign In",
                          style: TextStyle(
                              color: AppColor.primarycolor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                // mycontroller: ,
              ],
            ),
          )),
    );
  }
}
