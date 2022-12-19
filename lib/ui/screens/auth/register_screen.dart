import 'package:flutter/material.dart';
import 'package:transporter/ui/screens/auth/login_screen.dart';

import '../../../constants/app_strings.dart';
import '../../../helpers/app_helper.dart';
import '../../../helpers/fire_store_helper.dart';

class RegistrationScreen extends StatefulWidget {
  static const name = "\register";
  RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var mobileNumberController = TextEditingController();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  DatabaseService db = DatabaseService();
  bool _isBusy = false;

  updateisBusy(bool isBusy) {
    setState(() {
      _isBusy = isBusy;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(size * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(900),
                    color: Theme.of(context).primaryColor,
                    image: const DecorationImage(
                        image: AssetImage('assets/images/illustration-3.png'))),
              ),
              const SizedBox(height: 12),
              const Text(
                str_register,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(2, 2),
                        blurRadius: 12,
                        color: Color.fromRGBO(0, 0, 0, 0.16),
                      )
                    ]),
                child: Column(children: [
                  TextFormField(
                    controller: nameController,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.1)),
                        isDense: true,
                        isCollapsed: false,
                        prefixIcon: Icon(Icons.person),
                        hintText: "Name"),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: emailController,
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.1)),
                        isDense: true,
                        isCollapsed: false,
                        prefixIcon: Icon(Icons.email),
                        hintText: "Email"),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: mobileNumberController,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.1)),
                        isDense: true,
                        isCollapsed: false,
                        prefixText: str_91,
                        hintText: "Enter 10 Digit mobile number"),
                  ),
                  const SizedBox(height: 12),
                  if (_isBusy)
                    CircularProgressIndicator()
                  else
                    SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              updateisBusy(true);
                              if (mobileNumberController.text.length < 10) {
                                showSnakbarMsg(context, str_error_mobile);
                                updateisBusy(false);
                                return;
                              } else if (nameController.text.length < 4) {
                                showSnakbarMsg(context, str_name_required);
                                updateisBusy(false);
                                return;
                              } else if (!isEmail(emailController.text)) {
                                showSnakbarMsg(context, str_email_invalid);
                                updateisBusy(false);
                                return;
                              } else {
                                db
                                    .isMobileExist(mobileNumberController.text)
                                    .then((value) {
                                  print("mobile numer => ${value.docs.length}");
                                  if (value.docs.isNotEmpty) {
                                    showSnakbarMsg(
                                        context, str_error_mobile_exist);
                                    updateisBusy(false);
                                  }
                                });
                              }
                            },
                            child: const Text(str_register))),
                  TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, LoginScreen.name),
                      child: const Text(str_already_have_account))
                ]),
              ),
            ],
          ),
        ));
  }
}
