import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import '../../constants/app_strings.dart';
import '../../helpers/appPref.dart';
import '../../helpers/config.dart';
import '../../helpers/fire_store_helper.dart';
import '../../helpers/models/location_model.dart';
import '../widgets/auto_complete_location.dart';
import 'load_item.dart';

class SearchLoad extends StatefulWidget {
  static const name = "\searchLoad";
  const SearchLoad({super.key});
  @override
  State<SearchLoad> createState() => _SearchLoadState();
}

class _SearchLoadState extends State<SearchLoad> {
  DatabaseService db = DatabaseService();
  List<DocumentSnapshot> documentList = [];
  List<DocumentSnapshot> _documentList = [];
  List<Map<String, dynamic>> truckModelsList = [];
  ScrollController controller = ScrollController();
  List<QueryDocumentSnapshot>? snapshot_sort;
  Future<QuerySnapshot<Object?>>? futuresnap;
  var fromLocationController = TextEditingController();
  LocationModel? fromLocation = LocationModel('', 0.0, 0.0);
// DatabaseService.tbl_load, "created_user_id", "cXo4NlKeypD9D0J70hL6"
  @override
  initState() {
    _determinePosition().then((value) {
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .then((value) async {
        GeoData data = Geocoder2.getDataFromCoordinates(
            latitude: value.latitude,
            longitude: value.longitude,
            googleMapApiKey: map_key) as GeoData;
        print('Location  :$value');
        fromLocationController.text = data.address;

        db
            .getListwithWhereWithGeotag(
                DatabaseService.tbl_load,
                "created_user_id",
                SharedPrefs.getString(SharedPrefs.userId)!,
                value.latitude,
                fromLocation!.longitude)
            .then((records) {
          setState(() {
            fromLocation!.latitude = value.latitude;
            fromLocation!.longitude = value.longitude;
            _documentList = records.docs;
          });
        });
        // setState(() {
        //   fromLocation!.latitude = value.latitude;
        //   fromLocation!.longitude = value.longitude;
        // });
      });
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


  Future<QuerySnapshot<Object?>>? futureSnap() async {


  //  snapshot_sort  = snapshot.data!.docs;
    QuerySnapshot<Object?> ob = await db.getListwithWhereWithGeotag(
        DatabaseService.tbl_load,
        "created_user_id",
        SharedPrefs.getString(SharedPrefs.userId)!,
        fromLocation!.latitude,
        fromLocation!.longitude).then((value) {
          snapshot_sort = value.docs;
          setState(() {

          });

          return value;

    });


    return ob;

  }

  showBottomSheetFilter() {}

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    /*
    var slectVechilModel = SizedBox(
        height: 30,
        child: FutureBuilder(
          future: db.getTruckModels(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              );
            } else {
              if (snapshot.hasData) {
                return Row(
                    children: snapshot.data!.docs
                        .map((e) => InkWell(
                              onTap: () {
                                setState(() {
                                  _selected_vechil_model = e['name'];
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(e['name'],
                                      style: TextStyle(
                                          color: _selected_vechil_model ==
                                                  e['name']
                                              ? Theme.of(context).primaryColor
                                              : null))),
                            ))
                        .toList());
              } else {
                return Text("NO DATA");
              }
            }
          },
        ));
   */
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Search Loads",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            if (value == 1) {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return        Container(

                    // child: ListView.builder(
                    //   shrinkWrap: true,
                    //     itemCount: truckModelsList.length,
                    //     // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //     //     childAspectRatio: 1.2,
                    //     //     crossAxisCount: 3,
                    //     //     crossAxisSpacing: 3),
                    //     itemBuilder: (context, index) => InkWell(
                    //       onTap: () {
                    //         setState(() {
                    //           truckModelsList.forEach((element) {
                    //             if (element['selected'] == null) {
                    //               element['selected'] = false;
                    //             } else {
                    //               element['selected'] = false;
                    //             }
                    //           });
                    //
                    //           truckModelsList[index]['selected'] = true;
                    //
                    //           setState(() {
                    //
                    //           });
                    //         });
                    //       },
                    //       child: Container(
                    //         height: 50,
                    //         margin: EdgeInsets.all(2),
                    //         padding: EdgeInsets.all(5),
                    //         decoration: BoxDecoration(
                    //             color: truckModelsList[index]['selected'] == true
                    //                 ? Theme.of(context).primaryColor
                    //                 : Colors.white,
                    //             border: Border.all(
                    //                 color: Theme.of(context).primaryColor,
                    //                 width: 1),
                    //             borderRadius: BorderRadius.circular(8),
                    //             boxShadow: const [
                    //               BoxShadow(
                    //                 offset: Offset(2, 2),
                    //                 blurRadius: 12,
                    //                 color: Color.fromRGBO(0, 0, 0, 0.16),
                    //               )
                    //             ]),
                    //         child: Column(children: [
                    //           Expanded(child: Icon(Icons.fire_truck)),
                    //           Text(
                    //             truckModelsList[index]['name'],
                    //             style: TextStyle(
                    //               color:
                    //               truckModelsList[index]['selected'] == true
                    //                   ? Colors.white
                    //                   : Theme.of(context).primaryColor,
                    //             ),
                    //           ),
                    //           Text(truckModelsList[index]['desc'],
                    //               style: TextStyle(
                    //                 fontSize: 10,
                    //                 color:
                    //                 truckModelsList[index]['selected'] == true
                    //                     ? Colors.white
                    //                     : Theme.of(context).primaryColor,
                    //               ))
                    //         ]),
                    //       ),
                    //     )),
                  );
                },
              );
            } else {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextButton(
                              onPressed: () {
                                snapshot_sort!.sort((a,b)=>int.parse(a.get('price')).compareTo(int.parse(b.get('price'))));

                             debugPrint(snapshot_sort!.first.data().toString());

                                setState(() {
                                });
                                Navigator.pop(context);
                              }, child: Text("Price ASC")),
                          TextButton(
                              onPressed: () {
                                snapshot_sort!.sort((a,b)=>int.parse(b.get('price')).compareTo(int.parse(a.get('price'))));
                                setState(() {
                                });
                                Navigator.pop(context);
                              }, child: Text("Price DESC"))
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.sort),
              label: 'sort',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.filter_alt_outlined),
              label: 'filter',
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: AutoCompleteLocation(
                location: (location) {
                  setState(() {
                    fromLocation = location;
                    futuresnap = futureSnap();
                  });
                },
                controller: fromLocationController,
                helpText: str_from,
              ),
            ),
            // slectVechilModel,
            Expanded(
              child: FutureBuilder(
                future: futuresnap,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }  else if (snapshot.connectionState == ConnectionState.none) {
                    return const Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,

                      ),
                    );
                  } else {
                    if (snapshot.hasData) {

                      return ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: snapshot_sort!.length,
                          itemBuilder: (context, index) => LoadListItem(
                                data: snapshot_sort![index].data()
                                    as Map<String, dynamic>,
                              ));
                    } else {
                      return Text("NO DATA");
                    }
                  }
                },
              ),
            ),
          ],
        ));
  }
}
