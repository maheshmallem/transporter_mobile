// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:transporter/helpers/fire_store_helper.dart';
import 'package:transporter/helpers/models/location_model.dart';
import '../../../constants/app_strings.dart';
import '../../../helpers/app_helper.dart';
import '../../../helpers/app_styles.dart';
import '../../widgets/auto_complete_location.dart';
import '../../widgets/input_widget.dart';

class AddVechil extends StatefulWidget {
  static const name = "\addVechil";
  const AddVechil({super.key});

  @override
  State<AddVechil> createState() => _AddVechilState();
}

class _AddVechilState extends State<AddVechil> {
  DatabaseService db = DatabaseService();
  // String imageUrl = "";
  List<Map<String, dynamic>> statesList = [];
  List<Map<String, dynamic>> truckModelsList = [];
  var vechilNumber = TextEditingController();
  var currentLocation = TextEditingController();
  var quantityController = TextEditingController();
  var capacityController = TextEditingController();
  var numberOfTyresController = TextEditingController();
  var bodyTypeController = TextEditingController();
  var bodyDimensionController = TextEditingController();
  var descController = TextEditingController();
  LocationModel? currentVechilLocation;
  bool allIndiaPermit = false;
  List<String> selectedStates = [];
  Map<String, dynamic>? selectedTruck;
  String weightType = "Tonnes";
  int qtyIndex = 0;
  updateQtyIndex(int index) {
    setState(() {
      qtyIndex = index;
    });
  }

  @override
  void initState() {
    db.getStatesList().then((value) {
      print("states => ${value.docs.length}");
      var docs = value.docs;
      for (QueryDocumentSnapshot element in docs) {
        setState(() {
          statesList.add(element.data() as Map<String, dynamic>);
        });
      }
    });

    db.getTruckModels().then((value) {
      print("states => ${value.docs.length}");
      var docs = value.docs;
      for (QueryDocumentSnapshot element in docs) {
        setState(() {
          truckModelsList.add(element.data() as Map<String, dynamic>);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        str_add_vechil,
        style: TextStyle(color: Theme.of(context).primaryColor),
      )),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: shadowDecoration().copyWith(color: Colors.white),
        child: ListView(
          children: [
            const SizedBox(height: 12),
            InputWidget(
              icon: Icons.nine_mp_outlined,
              controller: vechilNumber,
              helptext: str_vechil_number,
            ),
            const SizedBox(height: 12),
            AutoCompleteLocation(
              location: (location) {
                setState(() {
                  currentVechilLocation = location;
                });
              },
              controller: currentLocation,
              helpText: str_current_location,
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              selectedTileColor: Theme.of(context).primaryColor,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: allIndiaPermit,
              onChanged: (v) {
                setState(() {
                  allIndiaPermit = v!;
                  if (v) {
                    statesList.forEach((e) {
                      e['selected'] = true;
                    });
                  } else {
                    statesList.forEach((e) {
                      e['selected'] = false;
                    });
                  }
                });
              },
              title: const Text(str_all_india_permint),
            ),
            Wrap(
                children: statesList
                    .map((e) => InkWell(
                          onTap: () {
                            setState(() {
                              if (e['selected'] == null) {
                                e['selected'] = true;
                              } else {
                                e['selected'] = !e['selected'];
                              }
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.all(2),
                              padding: EdgeInsets.all(5),
                              height: 25,
                              decoration: BoxDecoration(
                                  color: e['selected'] == true
                                      ? Theme.of(context).primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(2, 2),
                                      blurRadius: 4,
                                      color: Color.fromRGBO(0, 0, 0, 0.16),
                                    )
                                  ]),
                              child: Text(
                                e['name'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: e['selected'] == true
                                        ? Colors.white
                                        : Theme.of(context).primaryColor),
                              )),
                        ))
                    .toList()),
            /*
            ElevatedButton(
              child: Text("upload"),
              onPressed: () async {
                FirebaseStorage _storage = FirebaseStorage.instance;
                final ImagePicker _picker = ImagePicker();
                // Pick an image
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);
                print("Selected image path:${image!.path}");
                Reference reference = FirebaseStorage.instance
                    .ref()
                    .child('images/${image.name}');

                UploadTask uploadTask = reference.putFile(File(image.path));

                TaskSnapshot snapshot = await uploadTask;
                String url = await snapshot.ref.getDownloadURL();

                setState(() {
                  imageUrl = url;
                });
              },
            ),
            */
            const SizedBox(height: 12),
            Text(str_select_truck_model),
            const SizedBox(height: 4),
            Container(
              height: 200,
              child: GridView.builder(
                  itemCount: truckModelsList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.2,
                      crossAxisCount: 3,
                      crossAxisSpacing: 3),
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          setState(() {
                            truckModelsList.forEach((element) {
                              if (element['selected'] == null) {
                                element['selected'] = false;
                              } else {
                                element['selected'] = false;
                              }
                            });

                            truckModelsList[index]['selected'] = true;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(2),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: truckModelsList[index]['selected'] == true
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 1),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 12,
                                  color: Color.fromRGBO(0, 0, 0, 0.16),
                                )
                              ]),
                          child: Column(children: [
                            Expanded(child: Icon(Icons.fire_truck)),
                            Text(
                              truckModelsList[index]['name'],
                              style: TextStyle(
                                color:
                                    truckModelsList[index]['selected'] == true
                                        ? Colors.white
                                        : Theme.of(context).primaryColor,
                              ),
                            ),
                            Text(truckModelsList[index]['desc'],
                                style: TextStyle(
                                  fontSize: 10,
                                  color:
                                      truckModelsList[index]['selected'] == true
                                          ? Colors.white
                                          : Theme.of(context).primaryColor,
                                ))
                          ]),
                        ),
                      )),
            ),
            TextFormField(
              controller: capacityController,
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
                  labelText: str_capacity,
                  hintText: str_capacity),
            ),
            SizedBox(height: 8),
            InputWidget(
              icon: Icons.commit_sharp,
              controller: numberOfTyresController,
              helptext: str_number_of_tyres,
            ),
            SizedBox(height: 8),
            InputWidget(
              icon: Icons.border_style_sharp,
              controller: bodyTypeController,
              helptext: str_body_type,
            ),
            SizedBox(height: 8),
            InputWidget(
              icon: Icons.square_outlined,
              controller: bodyDimensionController,
              helptext: str_body_dimentions,
            ),
            SizedBox(height: 8),
            InputWidget(
              icon: Icons.square_outlined,
              controller: descController,
              helptext: str_description,
            ),
            SizedBox(height: 8),
            Container(
              child: ElevatedButton(
                child: Text(str_add_vechil),
                onPressed: () {
                  validate(context);
                },
              ),
              height: 45,
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 4,
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                )
              ]),
              width: double.infinity,
            ),
            SizedBox(height: 8),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  bool validate(BuildContext context) {
    if (vechilNumber.text.isEmpty) {
      showSnakbarMsg(context, "Vechil number required");
      return false;
    } else if (currentVechilLocation == null) {
      showSnakbarMsg(context, "Current location required");
      return false;
    } else if (capacityController.text.isEmpty) {
      showSnakbarMsg(context, "Capacity required");
      return false;
    } else if (numberOfTyresController.text.isEmpty) {
      showSnakbarMsg(context, "Tyres count required");
      return false;
    } else if (bodyTypeController.text.isEmpty) {
      showSnakbarMsg(context, "body type required");
      return false;
    } else if (bodyDimensionController.text.isEmpty) {
      showSnakbarMsg(context, "body dimention required");
      return false;
    } else if (descController.text.isEmpty) {
      showSnakbarMsg(context, "Description required");
      return false;
    } else if (statesList
        .where((element) => element['selected'] == true)
        .isEmpty) {
      showSnakbarMsg(context, "Select Atlest one state");
      return false;
    } else if (truckModelsList
        .where((element) => element['selected'] == true)
        .isEmpty) {
      showSnakbarMsg(context, "Select Vechil type");
      return false;
    } else {
      return true;
    }
  }
}
