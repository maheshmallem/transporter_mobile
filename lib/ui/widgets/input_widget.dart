import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  var controller = TextEditingController();
  TextInputType? keyboardType = TextInputType.text;
  String helptext;
  IconData icon;
  int? maxLength;
  InputWidget(
      {super.key,
      required this.controller,
      required this.helptext,
      required this.icon,
      this.keyboardType,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      decoration: InputDecoration(
          prefixIcon: Icon(icon), labelText: helptext, hintText: helptext),
    );
  }
}
