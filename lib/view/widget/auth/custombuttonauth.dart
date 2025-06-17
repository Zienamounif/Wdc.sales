import 'package:flutter/material.dart';

import '../../../core/constans/color.dart';

class CustomButtonAuth extends StatelessWidget {
   final String text;
   final void Function()? onPressed;
  const CustomButtonAuth({ Key? key, required this.text,this.onPressed }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: 10),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(vertical: 20),
              onPressed:onPressed ,
              color: AppColor.primarycolor,
              textColor: Colors.white,
              child: Text(text),
          ),
    );
  }
}