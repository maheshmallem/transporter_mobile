import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// import 'package:pinput/pinput.dart';
import 'package:transporter/ui/screens/_home/home_screen.dart';
import 'package:transporter/ui/screens/auth/login_screen.dart';

import '../../../constants/app_strings.dart';
import '../../../helpers/app_helper.dart';
import '../../../helpers/fire_store_helper.dart';

class OtpScreen extends StatelessWidget {
  static const name = "\otp";
  String mobileNumber;
  OtpScreen({super.key, required this.mobileNumber});

  DatabaseService db = DatabaseService();
  var otpController = TextEditingController();

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
                        image: AssetImage('assets/images/illustration-2.png'))),
              ),
              const SizedBox(height: 12),
              const Text(
                str_verification_code,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                str_code_sent_text,
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    mobileNumber,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, LoginScreen.name),
                      icon: const Icon(
                        Icons.edit,
                        size: 18,
                        color: Colors.grey,
                      ))
                ],
              ),
              const SizedBox(height: 12),
              Container(
                  height: 180,
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
                      PinCodeTextField(
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        backgroundColor: Colors.blue.shade50,
                        enableActiveFill: true,
                        // errorAnimationController: otpController,
                        controller: otpController,
                        onCompleted: (v) {
                          print("Completed");
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                        appContext: context, onChanged: (String value) {},
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                if (otpController.text == "000000") {
                                  Navigator.pushReplacementNamed(
                                      context, HomeScreen.name);
                                } else {
                                  showSnakbarMsg(context, str_invalid_otp);
                                }
                              },
                              child: const Text(str_login))),
                    ],
                  ))
            ],
          ),
        ));
  }
}
