import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/app_strings.dart';
import '../../helpers/call_backs.dart';

class AddPhoto extends StatefulWidget {
  StringCallback onSelected;

  AddPhoto({super.key, required this.onSelected});

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  String imageUrlRC = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            height: 200,
            child: imageUrlRC.isEmpty
                ? const Icon(
                    Icons.image,
                    size: 100,
                    color: Colors.grey,
                  )
                : Image.network(imageUrlRC)),
        ElevatedButton(
          child: const Text("Add Photo"),
          onPressed: () async {
            FirebaseStorage _storage = FirebaseStorage.instance;
            final ImagePicker _picker = ImagePicker();
            // Pick an image
            final XFile? image =
                await _picker.pickImage(source: ImageSource.gallery);
            print("Selected image path:${image!.path}");
            Reference reference =
                FirebaseStorage.instance.ref().child('images/${image.name}');

            UploadTask uploadTask = reference.putFile(File(image.path));

            TaskSnapshot snapshot = await uploadTask;
            String url = await snapshot.ref.getDownloadURL();

            setState(() {
              imageUrlRC = url;
              widget.onSelected(imageUrlRC);
            });
          },
        ),
      ],
    );
  }
}
