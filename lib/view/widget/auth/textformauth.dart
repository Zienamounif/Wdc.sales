import 'package:flutter/material.dart';

class TextFormAuth extends StatelessWidget {
  final String hinttext;
  final String labeltext;
  final IconData iconedata;
  final TextEditingController mycontroller;
  final String? Function(String?)? valid;
  final bool? obscuretext;
  final void Function()? onTapIcon;
  const TextFormAuth(
      {Key? key,
      this.obscuretext,
      this.onTapIcon,
      required this.hinttext,
      required this.labeltext,
      required this.iconedata,
      required this.mycontroller,
      required this.valid,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        validator: valid,
        controller: mycontroller,
        obscureText: obscuretext == null || obscuretext==false ? false :true,
        decoration: InputDecoration(
            hintText: hinttext,
            hintStyle: const TextStyle(fontSize: 14),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 9),
                child: Text(labeltext)),
            suffixIcon: InkWell(child: Icon(iconedata),onTap:onTapIcon),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
      ),
    );
  }
}
