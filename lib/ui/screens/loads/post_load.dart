import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:transporter/constants/app_strings.dart';

import '../../../helpers/app_helper.dart';
import '../../../helpers/app_styles.dart';
import '../../../helpers/fire_store_helper.dart';
import '../../../helpers/models/location_model.dart';
import '../../widgets/auto_complete_location.dart';
import '../../widgets/input_date_picker.dart';
import '../../widgets/input_time_picker.dart';
import '../../widgets/input_widget.dart';

class PostLoad extends StatefulWidget {
  static const name = "\postLoad";
  PostLoad({super.key});

  @override
  State<PostLoad> createState() => _PostLoadState();
}

class _PostLoadState extends State<PostLoad> {
  LocationModel? fromLocation;
  LocationModel? toLocation;

  var fromLocationController = TextEditingController();

  var toLocationController = TextEditingController();

  var startDateController = TextEditingController();

  var startDate = DateTime.now();

  var startTimeController = TextEditingController();

  var materialNameController = TextEditingController();

  var quantityController = TextEditingController();

  var priceController = TextEditingController();

  var descriptionController = TextEditingController();

  bool _isBusy = false;
  DatabaseService db = DatabaseService();
  updateisBusy(bool isBusy) {
    setState(() {
      _isBusy = isBusy;
    });
  }
String weightType = "Tonnes";
  int qtyIndex = 0;
  updateQtyIndex(int index) {
    setState(() {
      qtyIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          str_post_load,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: shadowDecoration(),
        child: ListView(
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
                            setState(() {
                              fromLocation = location;
                            });
                          },
                          controller: fromLocationController,
                          helpText: str_from,
                        ),
                        const SizedBox(height: 12),
                        AutoCompleteLocation(
                          location: (location) {
                            setState(() {
                              toLocation = location;
                            });
                          },
                          controller: toLocationController,
                          helpText: str_to,
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
                    controller: startDateController,
                    helptext: str_start_date,
                    dateSelected: (date) {
                      setState(() {
                        startDate = date;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  InputTimePicker(
                    controller: startTimeController,
                    helptext: str_start_time,
                  ),
                  const SizedBox(height: 10),
                  InputWidget(
                    icon: Icons.iron,
                    controller: materialNameController,
                    helptext: str_matrtial_name,
                  ),
                  const SizedBox(height: 10),
                  // InputLoad(
                  //   controller: quantityController,
                  //   helptext: str_quantity,
                  // ),
                  TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                    decoration: InputDecoration(
                        suffix: SizedBox(
                          height: 25,
                          child: // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
                              ToggleSwitch(
                            initialLabelIndex: qtyIndex,
                            totalSwitches: 2,
                            labels: const ['Tonnes', 'Liters'],
                            onToggle: (index) {
                              updateQtyIndex(index!);
                              setState(() {
                                if (index == 0) {
                                  weightType = "Tonnes";
                                } else {
                                  weightType = "Liters";
                                }
                              });
                            },
                          ),
                        ),
                        prefixIcon: const Icon(Icons.calculate_outlined),
                        labelText: str_quantity,
                        hintText: str_quantity),
                  ),
                  const SizedBox(height: 10),
                  InputWidget(
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    icon: Icons.money,
                    controller: priceController,
                    helptext: str_offer_price,
                  ),
                  const SizedBox(height: 10),
                  InputWidget(
                    icon: Icons.description,
                    controller: descriptionController,
                    helptext: str_description,
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 12),
                  if (_isBusy)
                    CircularProgressIndicator()
                  else
                    Container(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              updateisBusy(true);
                              if (validate()) {
                                Map<String, dynamic> postData = {};
                                print(
                                    "from_location => ${fromLocation!.location_name} \n to_location =>${toLocation!.location_name}");
                                try {
                                  postData = {
                                    "id": "",
                                    "from_location":
                                        fromLocationController.text,
                                    "to_location": toLocationController.text,
                                    "from_latitude": fromLocation!.latitude,
                                    "from_longitude": fromLocation!.longitude,
                                    "to_latitude": toLocation!.latitude,
                                    "to_longitude": toLocation!.longitude,
                                    "start_date": startDate.toIso8601String(),
                                    "start_time": startTimeController.text,
                                    "material_name":
                                        materialNameController.text,
                                    "qty": quantityController.text,
                                    "qty_type": weightType,
                                    "price": priceController.text,
                                    "desc": descriptionController.text,
                                    "created_date":
                                        DateTime.now().toIso8601String(),
                                    "updated_date":
                                        DateTime.now().toIso8601String(),
                                    "created_user_id": "cXo4NlKeypD9D0J70hL6"
                                  };
                                } catch (ex) {
                                  print("ERROR ${ex.toString()}");
                                }
                                print("Final Data :$postData");
                                db.createLoad(postData).then((value) {
                                  updateisBusy(false);
                                  showSnakbarMsg(
                                      context, "Created Successfully");
                                  Navigator.pop(context);
                                }).onError((error, stackTrace) {
                                  showSnakbarMsg(
                                      context, "ERROR : ${error.toString()}}");
                                  updateisBusy(false);
                                });
                              } else {
                                updateisBusy(false);
                              }
                            },
                            child: Text(str_post_load)))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validate() {
    if (fromLocationController.text.isEmpty) {
      showSnakbarMsg(context, "From location required");
      return false;
    } else if (toLocationController.text.isEmpty) {
      showSnakbarMsg(context, "To location required");
      return false;
    } else if (startDateController.text.isEmpty) {
      showSnakbarMsg(context, "Start date required");
      return false;
    } else if (startDate == null) {
      showSnakbarMsg(context, "Start-date required");
      return false;
    } else if (startTimeController.text.isEmpty) {
      showSnakbarMsg(context, "Start time required");
      return false;
    } else if (materialNameController.text.isEmpty) {
      showSnakbarMsg(context, "Material Name required");
      return false;
    } else if (quantityController.text.isEmpty) {
      showSnakbarMsg(context, "Quantity required");
      return false;
    } else if (priceController.text.isEmpty) {
      showSnakbarMsg(context, "Price required");
      return false;
    } else {
      return true;
    }
  }
}
