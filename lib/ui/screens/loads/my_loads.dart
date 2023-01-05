import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_strings.dart';
import '../../../helpers/fire_store_helper.dart';

class MyLoadsScreen extends StatelessWidget {
  static const name = "\myLoads";
  MyLoadsScreen({super.key});
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
                    itemBuilder: (context, index) => Container(
                          child: Card(
                              child: ListTile(
                            leading: const Icon(Icons.route),
                            title: Text(snapshot
                                .data!.docs[index]['to_location']
                                .toString()
                                .split(", ")[0]),
                          )),
                        ));
              } else {
                return Text("NO DATA");
              }
            }
          },
        ));
  }
}
