import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../helpers/fire_store_helper.dart';

class LoadListItem extends StatefulWidget {
  Map<String, dynamic> data = {};
  LoadListItem({super.key, required this.data});

  @override
  State<LoadListItem> createState() => _LoadListItemState();
}

class _LoadListItemState extends State<LoadListItem> {
  DatabaseService db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      child: Container(
        color: Colors.white,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            widget.data['from_location']
                                .toString()
                                .split(", ")[0],
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 3),
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
                            widget.data['to_location']
                                .toString()
                                .split(", ")[0],
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text("Price : ",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                Text(widget.data['qty'], style: const TextStyle(fontSize: 12))
              ],
            ),
            Row(
              children: [
                const Text("Start Date :",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                Text(widget.data['start_date'].toDate().toString() as String,
                    style: const TextStyle(fontSize: 12))
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
