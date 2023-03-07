import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../helpers/fire_store_helper.dart';
import 'trip_item.dart';

class SearchTrip extends StatefulWidget {
  static const name = "\Searchtrip";
  const SearchTrip({super.key});

  @override
  State<SearchTrip> createState() => _SearchTripState();
}

class _SearchTripState extends State<SearchTrip> {
  DatabaseService db = DatabaseService();
  List<DocumentSnapshot> documentList = [];
  ScrollController controller = ScrollController();

  @override
  void initState() {
    callApi();
    controller.addListener(_scrollListener);
    super.initState();
  }

  void callApi() {
    db
        .getListwithWherePagination(
            tblName: DatabaseService.tbl_trip,
            whereField: "created_user_id",
            whereValue: "cXo4NlKeypD9D0J70hL6",
            documentList: documentList)
        .then((value) {
      if (value != null && value.docs.length > 0) {
        setState(() {
          documentList.addAll(value.docs);
          print("API Rescount => ${documentList!.length}");
        });
      } else {
        print("NO DATA");
      }
    });
  }

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      print("at the end of list");
      callApi();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Search Trips", style: TextStyle(color:Theme.of(context).primaryColor),),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            controller: controller,
            itemCount: documentList == null ? 0 : documentList.length,
            itemBuilder: (context, index) => TripListItem(
                data: documentList[index].data() as Map<String, dynamic>)));
  }
}
