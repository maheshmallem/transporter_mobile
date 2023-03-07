import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../helpers/fire_store_helper.dart';
import '../screens/loads/my_load_item.dart';

class SearchLoad extends StatefulWidget {
  static const name = "\searchLoad";
  const SearchLoad({super.key});

  @override
  State<SearchLoad> createState() => _SearchLoadState();
}

class _SearchLoadState extends State<SearchLoad> {
  DatabaseService db = DatabaseService();
  List<DocumentSnapshot> documentList = [];
  ScrollController controller = ScrollController();
// DatabaseService.tbl_load, "created_user_id", "cXo4NlKeypD9D0J70hL6"
  @override
  void initState() {
    callApi();
    controller.addListener(_scrollListener);
    super.initState();
  }

  void callApi() {
    db
        .getListwithWherePagination(
            tblName: DatabaseService.tbl_load,
            whereField: "created_user_id",
            whereValue: "cXo4NlKeypD9D0J70hL6",
            documentList: documentList)
        .then((value) {
      if (value != null && value.docs.length > 0) {
        setState(() {
          documentList!.addAll(value.docs);
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
          title: Text(
            "Search Loads",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            controller: controller,
            itemCount: documentList == null ? 0 : documentList.length,
            itemBuilder: (context, index) => MyLoadListItem(
                data: documentList[index].data() as Map<String, dynamic>)));
  }
}
