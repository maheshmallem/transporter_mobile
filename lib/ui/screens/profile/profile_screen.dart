import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../constants/app_strings.dart';
import '../../../helpers/app_styles.dart';
import '../../../helpers/fire_store_helper.dart';

class ProfileScreen extends StatefulWidget {
  static const name = "\profile";
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DatabaseService db = DatabaseService();
  bool _edit = false;

  var fistName = TextEditingController();
  var lastName = TextEditingController();
  var email = TextEditingController();
  var mobile = TextEditingController();

  updateEditMode(bool edit) {
    setState(() {
      _edit = edit;
    });
  }

  selectImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // Capture a photo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              updateEditMode(!_edit);
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(_edit ? Icons.edit : Icons.done),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: db.getAccountDetails("7032214460"),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          } else if (snapshot.data!.docs.isEmpty) {
            return const Text(str_no_data_found);
          } else {
            //return Text(snapshot.data!.docs.first.get('active').toString());
            return Container(
                padding: const EdgeInsets.all(20),
                decoration: shadowDecoration(),
                child: _edit
                    ? Column(children: [
                        InkWell(
                          onTap: () {
                            selectImage();
                          },
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(
                                snapshot.data!.docs.first.get('image_url') ??
                                    ""),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                    labelText: 'First name',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20)))),
                                controller: fistName,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                    labelText: 'Last name',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20)))),
                                controller: lastName,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: email,
                        )
                      ])
                    : Column(children: [
                        const SizedBox(height: 8),
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                              snapshot.data!.docs.first.get('image_url') ?? ""),
                        ),
                        ListTile(
                          title: const Text(str_user_name),
                          subtitle: _edit
                              ? TextFormField(
                                  controller: TextEditingController(
                                      text: snapshot.data!.docs.first
                                          .get('first_name')),
                                )
                              : Text(
                                  "${snapshot.data!.docs.first.get('first_name')}  ${snapshot.data!.docs.first.get('last_name')}"),
                        ),
                        ListTile(
                          title: const Text(str_email),
                          subtitle:
                              Text("${snapshot.data!.docs.first.get('email')}"),
                        ),
                        ListTile(
                          title: const Text(str_mobile_number),
                          subtitle: Text(
                              "${snapshot.data!.docs.first.get('mobile_nummber')}"),
                        ),
                        ListTile(
                          title: const Text(str_gender),
                          subtitle: Text(
                              "${snapshot.data!.docs.first.get('gender')}"),
                        )
                      ]));
          }
        },
      ),
    );
  }
}
