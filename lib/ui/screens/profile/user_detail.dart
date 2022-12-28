import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.menu),
                color: Colors.black,
              )
            ],
          ),
          const SizedBox(height: 30),
          const Center(
            child: Text(
              'Welcome to  R-Transport',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 15),
          const Center(
            child: Text(
              'We Make Easy To Transport',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Book Unique Transports',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 35),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     TextButton(
          //       onPressed: () {},
          //       style: ButtonStyle(
          //           padding:
          //               MaterialStateProperty.all(const EdgeInsets.all(16)),
          //           backgroundColor: MaterialStateProperty.all(Colors.black),
          //           elevation: MaterialStateProperty.all(20),
          //           overlayColor: MaterialStateProperty.all(
          //               const Color.fromARGB(255, 174, 159, 159))),
          //       child: const Text(
          //         'Customer',
          //         style: TextStyle(fontSize: 20, color: Colors.white),
          //       ),
          //     ),
          //     TextButton(
          //       onPressed: () {},
          //       style: ButtonStyle(
          //           padding:
          //               MaterialStateProperty.all(const EdgeInsets.all(16)),
          //           backgroundColor: MaterialStateProperty.all(Colors.black),
          //           elevation: MaterialStateProperty.all(20),
          //           overlayColor: MaterialStateProperty.all(
          //               const Color.fromARGB(255, 174, 159, 159))),
          //       child: const Text(
          //         '    Driver     ',
          //         style: TextStyle(fontSize: 20, color: Colors.white),
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 40),
          Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Leaving From',
                  border: InputBorder.none,
                  icon: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFEEF8FF),
                    ),
                    child: const Icon(Icons.location_on),
                  ),
                ),
              ),
              const Divider(
                height: 40,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Going to',
                  border: InputBorder.none,
                  icon: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFEEF8FF),
                    ),
                    child: Icon(Icons.location_on),
                  ),
                ),
              ),
              const Divider(
                height: 40,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'description',
                  border: InputBorder.none,
                  icon: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFEEF8FF),
                    ),
                    child: Icon(Icons.description_outlined),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                height: 40,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Today',
                  border: InputBorder.none,
                  icon: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFEEF8FF),
                    ),
                    child: Icon(Icons.calendar_today),
                  ),
                ),
              ),
              const Divider(
                height: 40,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Goods Details',
                  border: InputBorder.none,
                  icon: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFEEF8FF),
                    ),
                    child: Icon(Icons.details_rounded),
                  ),
                ),
              ),
              const Divider(
                height: 40,
              ),
              SizedBox(
                height: 40,
              ),
              MaterialButton(
                height: 70,
                minWidth: double.infinity,
                color: const Color.fromARGB(255, 0, 0, 0),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             const OTPVerification()));
                },
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)),
                child: const Text(
                  "Search Vehicle ",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
