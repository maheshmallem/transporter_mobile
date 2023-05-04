import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporter/helpers/appPref.dart';
import 'package:transporter/ui/screens/loads/my_loads.dart';
import 'package:transporter/ui/screens/trips/my_trips.dart';
import 'package:transporter/ui/screens/trips/my_vechils.dart';

import '../../../data/provider/user_notifier.dart';
import '../../../helpers/fire_store_helper.dart';
import 'home_drawer.dart';
import 'home_options_grid.dart';

class HomeScreen extends StatefulWidget {
  static const name = "\home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseService db = DatabaseService();
  String username = '';
  @override
  void initState() {
    // Intilize User Data
    db
        .getAccountDetails(SharedPrefs.getString(SharedPrefs.mobileNumber)!)
        .then((value) {
      print('===>  Login User details : ${value.docs.first.data()}');
      SharedPrefs.setString(SharedPrefs.userId, value.docs.first.id);
      Provider.of<UserProvider>(context, listen: false)
          .updateUserData(value.docs.first.data());

      setState(() {
        username = value.docs.first['first_name'] +
            ' ' +
            value.docs.first['last_name'];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const HomeDrawer(),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Welcome back ",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.indigo[300],
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  Text(
                    username.toUpperCase(),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ],
              ),
              CarouselSlider(
                options: CarouselOptions(height: 150, autoPlay: true),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://t4.ftcdn.net/jpg/04/17/08/07/360_F_417080739_GWrTxh8RDIqaGdLKIM8RIkbYGIclTu1Z.jpg"),
                              fit: BoxFit.cover,
                            ),
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(14)),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 5),
              Row(children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, MyLoadsScreen.name);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(2.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: Text(
                      'My Loads',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),
                Expanded(
                    child: InkWell(
                  onTap: () => Navigator.pushNamed(context, MyTripsScreen.name),
                  child: Container(
                    margin: const EdgeInsets.all(2.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: Text(
                      'My Trips',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),
              ]),
              SizedBox(height: 5),
              Expanded(flex: 8, child: HomeOptionsGrid())
            ]),
      ),
    );
  }
}
