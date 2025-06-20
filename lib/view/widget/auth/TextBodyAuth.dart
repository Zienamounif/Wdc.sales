import 'package:flutter/material.dart';

class TextBodyAuth extends StatelessWidget {
  final String text;
  const TextBodyAuth({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
        ));
  }
}
