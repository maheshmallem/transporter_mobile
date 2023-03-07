import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../helpers/call_backs.dart';
import '../../../helpers/fire_store_helper.dart';

class DropDownVechil extends StatefulWidget {
  StringCallback onSelected;
  DropDownVechil({super.key, required this.onSelected});

  @override
  State<DropDownVechil> createState() => _DropDownVechilState();
}

class _DropDownVechilState extends State<DropDownVechil> {
  DatabaseService db = DatabaseService();
  DocumentSnapshot? selectedItem;

  List<DocumentSnapshot> data = [];

  @override
  void initState() {
    db
        .getListwithWhere(DatabaseService.tbl_user_vechils, "created_user_id",
            "cXo4NlKeypD9D0J70hL6")
        .then((value) {
      setState(() {
        data = value.docs;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Select Vechil"),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.white, border: Border.all(color: Colors.grey)),
            child: DropdownButton<DocumentSnapshot>(
              value: selectedItem,
              focusColor: Colors.white,
              underline: Container(),
              //elevation: 5,
              style: const TextStyle(color: Colors.white),
              iconEnabledColor: Colors.black,
              isExpanded: true,

              hint: const Text(
                "Please choose vechil",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              items: data.map((DocumentSnapshot value) {
                return DropdownMenuItem<DocumentSnapshot>(
                  value: value,
                  child: Text(value['vechil_number'],
                      style: const TextStyle(color: Colors.black)),
                );
              }).toList(),

              onChanged: (val) {
                widget.onSelected(val!['id']);
                setState(() {
                  selectedItem = val;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
