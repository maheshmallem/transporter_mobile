import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InputWidget extends StatelessWidget {
  var controller = TextEditingController();
  String helptext;
  InputWidget({super.key, required this.controller, required this.helptext});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: helptext, hintText: helptext),
    );
  }
}
