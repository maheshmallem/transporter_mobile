import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:transporter/ui/screens/loads/my_loads.dart';

import 'home_drawer.dart';
import 'home_options_grid.dart';

class HomeScreen extends StatelessWidget {
  static const name = "\home";
  const HomeScreen({super.key});

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
                    "Mahesh Mallem",
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
                )),
              ]),
              SizedBox(height: 5),
              Expanded(flex: 8, child: HomeOptionsGrid())
            ]),
      ),
    );
  }
}
