import 'package:flutter/material.dart';

class InputTimePicker extends StatelessWidget {
  var controller = TextEditingController();
  String helptext;
  InputTimePicker({
    super.key,
    required this.controller,
    required this.helptext,
  });

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
      controller.text = value!.format(context);
    });
  }
}
