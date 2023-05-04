import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:transporter/helpers/models/user_model.dart';

import 'helpers/fire_store_helper.dart';

class TestScreen extends StatelessWidget {
  static const name = "\test";
  TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("MAHESH"),
          onPressed: () {
            // db
            //     .getSingleRecord("tel_user", "CMkxUWdJPg6Nq3hp30i7")
            //     .then((value) => print(value.toString()));
            DatabaseService db = DatabaseService();
            
            // db
            //     .createUser(UserModel(
            //             id: "",
            //             firstName: "mahesh",
            //             lastName: "mallem",
            //             imageUrl: "",
            //             mobileNummber: "7032214460",
            //             email: "mallemmahesh@gmail.com",
            //             role: "user",
            //             gender: "male",
            //             active: true,
            //             verifiedPhone: false,
            //             verifiedEmail: false,
            //             dateOfBirth: DateTime.now(),
            //             createdDate: DateTime.now(),
            //             lastLoginDate: DateTime.now(),
            //             updatedDate: DateTime.now())
            //         .toJson())
            //     .then((value) => print(value.toString()));
          },
        ),
      ),
    );
  }
}
