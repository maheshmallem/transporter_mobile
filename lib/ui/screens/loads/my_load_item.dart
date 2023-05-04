import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../helpers/fire_store_helper.dart';

class MyLoadListItem extends StatefulWidget {
  Map<String, dynamic> data = {};
  bool showDelete = false;
  MyLoadListItem({super.key, required this.data, this.showDelete = false});

  @override
  State<MyLoadListItem> createState() => _MyLoadListItemState();
}

class _MyLoadListItemState extends State<MyLoadListItem> {
  DatabaseService db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    bool deleted = false;
    try {
      deleted = widget.data['deleted'];
    } catch (e) {}

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
                if (widget.showDelete)
                  TextButton(
                      onPressed: () {
                        if (deleted == false) {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(32.0))),
                                    backgroundColor: Colors.white70,
                                    title: const Text('Delete'),
                                    content: const Text(
                                        'Are you sure you want to delete this item'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          db
                                              .deleteLoad(
                                                  widget.data['id'].toString(),
                                                  !deleted)
                                              .then((value) {
                                            setState(() {
                                              widget.data['deleted'] = !deleted;
                                            });
                                            Navigator.pop(context, 'Cancel');
                                          });
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ));
                        } else {
                          db
                              .deleteLoad(
                                  widget.data['id'].toString(), !deleted)
                              .then((value) {
                            setState(() {
                              setState(() {
                                widget.data['deleted'] = !deleted;
                              });
                              // Navigator.pop(context, 'Cancel');
                              // widget.data['deleted'] = true;
                            });
                          });
                        }
                      },
                      child: Text(
                        deleted ? "Un-Delete" : "Delete",
                        style: const TextStyle(color: Colors.red),
                      ))
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
