import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transporter/ui/screens/loads/my_load_item.dart';

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
                    itemBuilder: (context, index) => MyLoadListItem(
                          data: snapshot.data!.docs[index].data()
                              as Map<String, dynamic>,
                          showDelete: true,
                        ));
              } else {
                return Text("NO DATA");
              }
            }
          },
        ));
  }
}
