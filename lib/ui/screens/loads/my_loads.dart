import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_strings.dart';
import '../../../helpers/fire_store_helper.dart';

class MyLoadsScreen extends StatefulWidget {
  static const name = "\myLoads";
  MyLoadsScreen({super.key});

  @override
  State<MyLoadsScreen> createState() => _MyLoadsScreenState();
}

class _MyLoadsScreenState extends State<MyLoadsScreen> {
  DatabaseService db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            str_my_loads,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        body: FutureBuilder(
          future: db.getListwithWhere(DatabaseService.tbl_load,
              "created_user_id", "cXo4NlKeypD9D0J70hL6"),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 40,
                width: 40,
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              if (snapshot.hasData) {
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      bool deleted = false;
                      try {
                        deleted = snapshot.data!.docs[index]['deleted'];
                      } catch (e) {}

                      String start_date =
                          snapshot.data!.docs[index]['start_date'];

                      try {
                        // start_date = '2021-01-26T03:17:00.000000Z';
                        DateTime parseDate =
                            new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'")
                                .parse(start_date);
                        var inputDate = DateTime.parse(parseDate.toString());
                        var outputFormat = DateFormat('dd-MM-yyyy');
                        var outputDate = outputFormat.format(inputDate);
                        // start_date = DateFormat("yyyy-MM-dd")
                        //     .parse("2002-02-27T14:00:00-0500"
                        //         // snapshot.data!.docs[index]['start_date']
                        //         )
                        //     .toString();

                        start_date = outputDate;
                      } catch (e) {}
                      // start_date = "mahesh";
                      return Container(
                          child: Card(
                        child: Container(
                          color: deleted ? Colors.grey[100] : Colors.white,
                          padding: EdgeInsets.all(7),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
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
                                              snapshot.data!
                                                  .docs[index]['from_location']
                                                  .toString()
                                                  .split(", ")[0],
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Container(
                                            margin:
                                                const EdgeInsets.only(left: 3),
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
                                              snapshot.data!
                                                  .docs[index]['to_location']
                                                  .toString()
                                                  .split(", ")[0],
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        db
                                            .deleteLoad(
                                                snapshot.data!.docs[index]['id']
                                                    .toString(),
                                                !deleted)
                                            .then((value) {
                                          setState(() {});
                                        });
                                      },
                                      child: Text(
                                        deleted ? "Un-Delete" : "Delete",
                                        style: TextStyle(color: Colors.red),
                                      ))
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text("Start Date :",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                        Text(start_date,
                                            style:
                                                const TextStyle(fontSize: 12))
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Text("Material :",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            "${snapshot.data!.docs[index]['material_name']} (${snapshot.data!.docs[index]['qty']}  ${snapshot.data!.docs[index]['qty_type']})",
                                            style:
                                                const TextStyle(fontSize: 12))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ));
                    });
              } else {
                return Text("NO DATA");
              }
            }
          },
        ));
  }
}
