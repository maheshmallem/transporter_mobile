import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../helpers/fire_store_helper.dart';

class MyVechilsScreen extends StatelessWidget {
  static const name = "\myvechils";
  DatabaseService db = DatabaseService();
  MyVechilsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "My Vehicles",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        body: FutureBuilder(
          future: db.getListwithWhere(DatabaseService.tbl_user_vechils,
              "created_user_id", "cXo4NlKeypD9D0J70hL6"),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (snapshot.hasData) {
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                snapshot.data!.docs[index]['vechil_number'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            if (snapshot.data!.docs[index]['verified'])
                              Icon(Icons.verified_outlined,
                                  color: Theme.of(context).primaryColor)
                            else
                              TextButton(
                                child: Text("Verify Request"),
                                onPressed: () {},
                              )
                          ],
                        ),
                        subtitle: Column(children: [
                          Row(
                            children: [
                              Text("Location :",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(snapshot.data!.docs[index]['location']),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Model :",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(snapshot.data!.docs[index]['truck_model']),
                            ],
                          )
                        ]),
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
