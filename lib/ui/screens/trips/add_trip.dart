import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_strings.dart';
import '../../../helpers/app_helper.dart';
import '../../../helpers/app_styles.dart';
import '../../../helpers/fire_store_helper.dart';
import '../../../helpers/models/location_model.dart';
import '../../widgets/auto_complete_location.dart';
import '../../widgets/input_date_picker.dart';
import '../../widgets/input_widget.dart';
import 'vechil_drop_down.dart';

class AddTrip extends StatefulWidget {
  static const name = "\addTrip";

  AddTrip({super.key});

  @override
  State<AddTrip> createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  DatabaseService db = DatabaseService();
  LocationModel? fromLocation;
  LocationModel? toLocation;
  var fromLocationController = TextEditingController();
  var toLocationController = TextEditingController();
  var descController = TextEditingController();
  var priceController = TextEditingController();
  var startDateController = TextEditingController();
  String? selectedVechilId;
  var startDate = DateTime.now();
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
              DropDownVechil(
                onSelected: (String str) {
                  setState(() {
                    selectedVechilId = str;
                  });
                  print("selected Vechil =>$str");
                },
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
                icon: Icons.iron,
                controller: descController,
                helptext: str_description,
              ),
              const SizedBox(height: 10),
              Container(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (validator()) {
                          Map<String, dynamic> postData = {};
                          print(
                              "from_location => ${fromLocation!.location_name} \n to_location =>${toLocation!.location_name}");
                          try {
                            postData = {
                              "id": "",
                              "from_location": fromLocationController.text,
                              "to_location": toLocationController.text,
                              "from_latitude": fromLocation!.latitude,
                              "from_longitude": fromLocation!.longitude,
                              "to_latitude": toLocation!.latitude,
                              "to_longitude": toLocation!.longitude,
                              "price": priceController.text,
                              "start_date": startDate.toIso8601String(),
                              "vechil_id": selectedVechilId,
                              "desc": descController.text,
                              "created_date": DateTime.now().toIso8601String(),
                              "updated_date": DateTime.now().toIso8601String(),
                              "created_user_id": "cXo4NlKeypD9D0J70hL6"
                            };
                          } catch (ex) {
                            print("ERROR ${ex.toString()}");
                          }
                          db.addTrip(postData).then((value) {
                            showSnakbarMsg(context, "Created Successfully");
                            Navigator.pop(context);
                          });
                        }
                      },
                      child: Text(str_add_trip)))
            ],
          ),
        ));
  }

  bool validator() {
    if (fromLocationController.text.isEmpty) {
      showSnakbarMsg(context, "From location required");
      return false;
    } else if (toLocationController.text.isEmpty) {
      showSnakbarMsg(context, "To location required");
      return false;
    } else if (selectedVechilId == null) {
      showSnakbarMsg(context, "Vechil required");
      return false;
    } else if (priceController.text.isEmpty) {
      showSnakbarMsg(context, "Price required");
      return false;
    } else if (descController.text.isEmpty) {
      showSnakbarMsg(context, "Description required");
      return false;
    } else {
      return true;
    }
  }
}
