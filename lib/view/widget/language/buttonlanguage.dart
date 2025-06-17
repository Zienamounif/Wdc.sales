import 'package:flutter/material.dart';

import '../../../core/constans/color.dart';

class ButtonLanguage extends StatelessWidget {
  final String textbutton;
  final void Function()? onPressed;
  const ButtonLanguage({Key? key, required this.textbutton, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      width: double.infinity,
      child: MaterialButton(
        color: AppColor.primarycolor,
        textColor: Colors.white,
        child: Text(
          textbutton,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: onPressed,
      ),
    );
    ;
  }
}
