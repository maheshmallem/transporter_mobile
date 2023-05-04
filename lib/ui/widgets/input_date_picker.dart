import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../helpers/call_backs.dart';

class InputDatePicker extends StatelessWidget {
  var controller = TextEditingController();

  String helptext;
  DateCallback dateSelected;
  InputDatePicker(
      {super.key,
      required this.controller,
      required this.helptext,
      required this.dateSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => displayCakender(context),
      child: IgnorePointer(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.calendar_month_outlined),
              labelText: helptext,
              hintText: helptext),
        ),
      ),
    );
  }

  displayCakender(BuildContext context) {
    TimeOfDay timeOfDay = TimeOfDay(hour: 3, minute: 10);
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 7)))
        .then((value) {
      String dateis = DateFormat("dd-MM-yyyy").format(value!);
      print("Selected date ${value.toIso8601String()}");
      controller.text = dateis;
      // date = value;
      dateSelected(value);
    });
  }
}
