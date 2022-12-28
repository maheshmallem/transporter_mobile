import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showpass = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 25),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              // const Text(
              //   'Edit Profile',
              //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              // ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: Colors.white,
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10),
                          )
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://pbs.twimg.com/profile_images/1585132762067275776/eSJ0Othk_400x400.jpg'),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 4, color: Colors.white),
                          color: Colors.black,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.edit),
                          color: Colors.white,
                          iconSize: 17,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              buildTextFlied('First Name', 'ex : Pravieen', false),
              buildTextFlied('Last Name', 'ex : A S', false),
              buildTextFlied('E-mail', 'ex : abc@gmail.com', false),

              buildTextFlied('Phone', 'ex : 1234567890', false),
              buildTextFlied('Loaction', 'ex : TanilNadu', false),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    height: 40,
                    minWidth: 100,
                    color: Color.fromARGB(255, 229, 49, 49),
                    onPressed: () {},
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60)),
                    child: const Text(
                      "Cancle",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                  MaterialButton(
                    height: 40,
                    minWidth: 100,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    onPressed: () {},
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60)),
                    child: const Text(
                      "Save",
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
        ),
      ),
    );
  }

  Widget buildTextFlied(
      String lablrText, String hintText, bool passwordTextFlied) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: passwordTextFlied ? showpass : false,
        decoration: InputDecoration(
          suffixIcon: passwordTextFlied
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      showpass = !showpass;
                    });
                  },
                  child: const Icon(Icons.remove_red_eye),
                )
              : null,
          contentPadding: const EdgeInsets.only(bottom: 5),
          labelText: lablrText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w700, color: Colors.black, fontSize: 18),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black45,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
