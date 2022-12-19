import 'package:flutter/material.dart';

appLog(String className, String methodName, String msg) {
  print("---------------------------------\n $className \n $msg");
}

showSnakbarMsg(BuildContext context, String value) {
  Future.delayed(Duration.zero, () {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blue[100],
        content: Text(value, style: const TextStyle(color: Colors.black))));
  });
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}
