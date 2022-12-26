import 'package:flutter/material.dart';
import 'package:transporter/helpers/models/location_model.dart';
import '../../../helpers/app_styles.dart';
import '../../widgets/auto_complete_location.dart';
import '../../widgets/input_date_picker.dart';
import '../../widgets/input_time_picker.dart';
import '../../widgets/input_widget.dart';

class AddTrip extends StatelessWidget {
  static const name = "\addTrip";
  AddTrip({super.key});
  var fromLocationController = TextEditingController();
  var toLocationController = TextEditingController();

  DateTime? startDate;
  LocationModel? fromLocation;
  LocationModel? toLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Trip",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: shadowDecoration(),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10, right: 10, bottom: 10),
              decoration: shadowDecoration(),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 10,
                          ),
                          Container(
                            width: 2,
                            height: 90,
                            color: Theme.of(context).primaryColor,
                          ),
                          const Icon(
                            Icons.circle,
                            size: 10,
                          )
                        ],
                      )),
                  Expanded(
                    flex: 9,
                    child: Column(
                      children: [
                        AutoCompleteLocation(
                          location: (location) {
                            fromLocation = location;
                          },
                          controller: fromLocationController,
                          helpText: "From Location",
                        ),
                        const SizedBox(height: 12),
                        AutoCompleteLocation(
                          location: (location) {
                            toLocation = location;
                          },
                          controller: toLocationController,
                          helpText: "Destination",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: shadowDecoration(),
              child: Column(
                children: [
                  InputDatePicker(
                    controller: TextEditingController(),
                    helptext: 'Start Date',
                    dateSelected: (date) {
                      startDate = date;
                    },
                  ),
                  const SizedBox(height: 10),
                  InputTimePicker(
                    controller: TextEditingController(),
                    helptext: "Start time",
                  ),
                  const SizedBox(height: 10),
                  InputWidget(
                    icon: Icons.description,
                    controller: TextEditingController(),
                    helptext: 'Description',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
