import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TextTittleAuth extends StatelessWidget {
   final String text;
  const TextTittleAuth({ Key? key, required this.text }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Text(
             text,
             textAlign: TextAlign.center,
             style: Theme.of(context).textTheme.headline2,);
  }
}