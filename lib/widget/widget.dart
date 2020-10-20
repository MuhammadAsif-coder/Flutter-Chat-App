import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
      title: Text("Flutter Chat App",
          style: TextStyle(color: Colors.white, fontSize: 17)));
}

Container logocontainer() {
  return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          gradient: LinearGradient(
            colors: [const Color(0xff007EF4), const Color(0xff2A75BC)],
          )),
      child: Image.asset(
        "assets/images/send.png",
        height: 150,
      ));
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.black54),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)));
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.black, fontSize: 16);
}

TextStyle biggerTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 17);
}
