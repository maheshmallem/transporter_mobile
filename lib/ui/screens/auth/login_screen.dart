import 'package:flutter/material.dart';
import 'package:transporter/helpers/fire_store_helper.dart';
import 'package:transporter/ui/screens/auth/otp_screen.dart';
import 'package:transporter/ui/screens/auth/register_screen.dart';
import '../../../constants/app_strings.dart';
import '../../../helpers/app_helper.dart';

class LoginScreen extends StatefulWidget {
  static const name = "\login";
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DatabaseService db = DatabaseService();
  var mobileNumberController = TextEditingController();
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
                        image: AssetImage('assets/images/illustration-1.png'))),
              ),
              const SizedBox(height: 12),
              const Text(
                'Login',
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
                  child: Column(
                    children: [
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
                                  } else {
                                    db
                                        .isMobileExist(
                                            mobileNumberController.text)
                                        .then((value) {
                                      print(
                                          "mobile numer => ${value.docs.length}");
                                      if (value.docs.isEmpty) {
                                        updateisBusy(false);
                                        showSnakbarMsg(
                                            context, str_error_mobile_exist);
                                      } else {
                                        updateisBusy(false);
                                        Navigator.pushReplacementNamed(
                                            context, OtpScreen.name,
                                            arguments:
                                                mobileNumberController.text);
                                      }
                                    });
                                  }
                                },
                                child: const Text(str_login))),
                      TextButton(
                          onPressed: () => Navigator.pushReplacementNamed(
                              context, RegistrationScreen.name),
                          child: const Text(str_dont_have_account)),
                    ],
                  ))
            ],
          ),
        ));
  }
}
