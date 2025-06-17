import 'package:get/get.dart';

   validInput( String val, int min, int max, String type){

  if(type=='firstName'){

    if(!GetUtils.isUsername(val)){

       return "not valid username";

    }

  }
    if(type=='lastName'){

    if(!GetUtils.isUsername(val)){

       return "not valid username";

    }

  }
    if(type=='email'){

    if(!GetUtils.isEmail(val)){

       return "not valid email";

    }

  }
  if (type == 'password') {
  
    // تحقق من وجود حرف كبير
    if (!RegExp(r'[A-Z]').hasMatch(val)) {
      return "Password must contain at least one uppercase letter";
    }
    // تحقق من وجود حرف خاص
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(val)) {
      return "Password must contain at least one special character";
    }
    // تحقق من وجود رقم
    if (!RegExp(r'[0-9]').hasMatch(val)) {
      return "Password must contain at least one number";
    }
  }

 if(val.isEmpty){
  return "can't be Empty";
 }
 if(val.length<min){
   return "can't be less than $min";
 }
  if(val.length>max){
   return "can't be large than $max";
 }
}