import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class InputLoad extends StatelessWidget {
  var controller = TextEditingController();
  String helptext;

  InputLoad({
    super.key,
    required this.controller,
    required this.helptext,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 5,
      decoration: InputDecoration(
          suffix: SizedBox(
            height: 25,
            child: // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
                ToggleSwitch(
              initialLabelIndex: 0,
              totalSwitches: 2,
              labels: const ['Tonnes', 'Liters'],
              onToggle: (index) {
                print('switched to: $index');
              },
            ),
          ),
          prefixIcon: const Icon(Icons.calculate_outlined),
          labelText: helptext,
          hintText: helptext),
    );
  }
}
