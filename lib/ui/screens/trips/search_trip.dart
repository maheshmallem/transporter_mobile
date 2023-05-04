import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../constants/app_strings.dart';
import '../../../helpers/appPref.dart';
import '../../../helpers/config.dart';
import '../../../helpers/fire_store_helper.dart';
import '../../../helpers/models/location_model.dart';
import '../../widgets/auto_complete_location.dart';
import 'trip_item.dart';

class SearchTrip extends StatefulWidget {
  static const name = "\Searchtrip";
  const SearchTrip({super.key});

  @override
  State<SearchTrip> createState() => _SearchTripState();
}

class _SearchTripState extends State<SearchTrip> {
  DatabaseService db = DatabaseService();
  List<Map<String, dynamic>> truckModelsList = [];
  var fromLocationController = TextEditingController();
  LocationModel? fromLocation = LocationModel('', 0.0, 0.0);
  List<QueryDocumentSnapshot>? snapshot_sort;
  List<QueryDocumentSnapshot>? snapshot_sort_temp;
  Future<QuerySnapshot<Object?>>? futuresnap;
  List<dynamic> _selecttrucks = [];
  @override
  initState() {
    _determinePosition().then((value) {
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .then((value) async {
        GeoData data = await Geocoder2.getDataFromCoordinates(
            latitude: value.latitude,
            longitude: value.longitude,
            googleMapApiKey: map_key) as GeoData;
        print('Location  :$value');
    //    fromLocationController.text = data.address;
        setState(() {
          fromLocation!.latitude = value.latitude;
          fromLocation!.longitude = value.longitude;
        });
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
        DatabaseService.tbl_trip,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Search Trip",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            if (value == 1) {
              showModalBottomSheet(
                isScrollControlled: true, // required for min/max child size
                context: context,
                builder: (ctx) {
                  return  MultiSelectBottomSheet(

                    items: truckModelsList.map((e) => MultiSelectItem(e['name'], e['name'])).toList(),

                    onConfirm: (values) {

                      _selecttrucks = values ;

                      setState(() {

                      });
                    },
                    maxChildSize: 0.8, initialValue: _selecttrucks,
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
            Expanded(
              child: FutureBuilder(
                future:futuresnap ,
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
                  } else  if (snapshot.connectionState == ConnectionState.none) {
                    return const Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,

                      ),
                    );
                  } else {
                    if (snapshot.hasData) {


                      if(_selecttrucks.isEmpty){
                        return ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: snapshot_sort!.length,
                            itemBuilder: (context, index)
                            {
                              String start_date =
                              snapshot_sort![index]['start_date'];
                              try {
                                // start_date = '2021-01-26T03:17:00.000000Z';
                                DateTime parseDate =
                                new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'")
                                    .parse(start_date);
                                var inputDate =
                                DateTime.parse(parseDate.toString());
                                var outputFormat = DateFormat('dd-MM-yyyy');
                                var outputDate = outputFormat.format(inputDate);
                                // start_date = DateFormat("yyyy-MM-dd")
                                //     .parse("2002-02-27T14:00:00-0500"
                                //         // data['start_date']
                                //         )
                                //     .toString();

                                start_date = outputDate;
                              } catch (e) {}
                              return Card(
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(children: [
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.circle_outlined,
                                                  size: 8,
                                                  color: Colors.green,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  snapshot_sort![index]['from_location']
                                                      .toString()
                                                      .split(", ")[0],
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    left: 3),
                                                height: 10,
                                                width: 1,
                                                color: Colors.grey),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.circle_outlined,
                                                  size: 8,
                                                  color: Colors.red,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  snapshot_sort![index]['to_location']
                                                      .toString()
                                                      .split(", ")[0],
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Text("Start Date : ",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold)),
                                            Text(start_date,
                                                style:
                                                const TextStyle(fontSize: 12))
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text("Price : ",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold)),
                                            Text(
                                                snapshot_sort![index]
                                                ['price'],
                                                style:
                                                const TextStyle(fontSize: 12))
                                          ],
                                        ),
                                        FutureBuilder(
                                            future: db.getSingleRecord(
                                                DatabaseService.tbl_user_vechils,
                                                snapshot_sort![index]
                                                ['vechil_id']),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<
                                                    QuerySnapshot<Object?>>
                                                snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                    child:
                                                    const CircularProgressIndicator());
                                              } else if (snapshot
                                                  .data!.docs.isEmpty) {
                                                return const Text(
                                                    str_no_data_found);
                                              } else {
                                                return Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            "Vechil Number : ",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                        Text(
                                                            snapshot.data!.docs
                                                                .first[
                                                            "vechil_number"],
                                                            style:
                                                            const TextStyle(
                                                                fontSize: 12))
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text("Capacity : ",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                        Text(
                                                            snapshot.data!.docs
                                                                .first[
                                                            'capacity'],
                                                            style:
                                                            const TextStyle(
                                                                fontSize: 12))
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              }
                                            }),
                                      ])));
                            });
                      }else{

                        snapshot_sort_temp = [];
                        for (var element1 in _selecttrucks) {
                          for (var element in snapshot_sort!) {


                            if(element['truck_model']==element1)

                              snapshot_sort_temp!.add(element);

                          }

                        }



                        return snapshot_sort_temp!.isEmpty? Container(child: Text("NO DATA FOUND FROM FILTER"),) : ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: snapshot_sort_temp!.length,
                            itemBuilder: (context, index)
                            {
                              String start_date =
                              snapshot_sort_temp![index]['start_date'];
                              try {
                                // start_date = '2021-01-26T03:17:00.000000Z';
                                DateTime parseDate =
                                new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'")
                                    .parse(start_date);
                                var inputDate =
                                DateTime.parse(parseDate.toString());
                                var outputFormat = DateFormat('dd-MM-yyyy');
                                var outputDate = outputFormat.format(inputDate);
                                // start_date = DateFormat("yyyy-MM-dd")
                                //     .parse("2002-02-27T14:00:00-0500"
                                //         // data['start_date']
                                //         )
                                //     .toString();

                                start_date = outputDate;
                              } catch (e) {}
                              return Card(
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(children: [
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.circle_outlined,
                                                  size: 8,
                                                  color: Colors.green,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  snapshot_sort_temp![index]['from_location']
                                                      .toString()
                                                      .split(", ")[0],
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    left: 3),
                                                height: 10,
                                                width: 1,
                                                color: Colors.grey),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.circle_outlined,
                                                  size: 8,
                                                  color: Colors.red,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  snapshot_sort_temp![index]['to_location']
                                                      .toString()
                                                      .split(", ")[0],
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Text("Start Date : ",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold)),
                                            Text(start_date,
                                                style:
                                                const TextStyle(fontSize: 12))
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text("Price : ",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold)),
                                            Text(
                                                snapshot_sort_temp![index]
                                                ['price'],
                                                style:
                                                const TextStyle(fontSize: 12))
                                          ],
                                        ),
                                        FutureBuilder(
                                            future: db.getSingleRecord(
                                                DatabaseService.tbl_user_vechils,
                                                snapshot_sort_temp![index]
                                                ['vechil_id']),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<
                                                    QuerySnapshot<Object?>>
                                                snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                    child:
                                                    const CircularProgressIndicator());
                                              } else if (snapshot
                                                  .data!.docs.isEmpty) {
                                                return const Text(
                                                    str_no_data_found);
                                              } else {
                                                return Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            "Vechil Number : ",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                        Text(
                                                            snapshot.data!.docs
                                                                .first[
                                                            "vechil_number"],
                                                            style:
                                                            const TextStyle(
                                                                fontSize: 12))
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text("Capacity : ",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                        Text(
                                                            snapshot.data!.docs
                                                                .first[
                                                            'capacity'],
                                                            style:
                                                            const TextStyle(
                                                                fontSize: 12))
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              }
                                            }),
                                      ])));
                            });

                      }



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

  _determinePosition() async {
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
}
