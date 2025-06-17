

import 'package:ecormmec/core/constans/routes.dart';
import 'package:ecormmec/core/middelware/middleware.dart';

import 'package:ecormmec/view/screen/auth/homenavigationbar.dart';
import 'package:ecormmec/view/screen/auth/login.dart';
import 'package:ecormmec/view/screen/auth/signup.dart';

import 'package:ecormmec/view/screen/view/orders.dart';

import 'package:get/get.dart';


List<GetPage<dynamic>>? routes =[

  GetPage(name:"/", page: ()=>const Login(),middlewares:[Middleware()]),
  GetPage(name: Approute.login, page: ()=>const Login()),
  GetPage(name: Approute.signup, page: ()=>const SignUp()),
  GetPage(name: Approute.home, page: ()=>const HomeNavigation()),
  GetPage(name: Approute.orders, page: ()=>const Orders()),



];
