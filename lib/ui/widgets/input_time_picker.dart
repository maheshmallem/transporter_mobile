import 'package:flutter/material.dart';

import '../../helpers/call_backs.dart';

class InputTimePicker extends StatelessWidget {
  var controller = TextEditingController();
  TimeCallback timeCallback;
  String helptext;
  InputTimePicker(
      {super.key,
      required this.controller,
      required this.helptext,
      required this.timeCallback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => displayCakender(context),
      child: IgnorePointer(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.av_timer_rounded),
              labelText: helptext,
              hintText: helptext),
        ),
      ),
    );
  }

  displayCakender(BuildContext context) {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      timeCallback(value!);
      controller.text = value!.format(context);
    });
  }
}
