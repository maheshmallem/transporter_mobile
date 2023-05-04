import 'package:flutter/material.dart';
import 'package:transporter/ui/screens/loads/post_load.dart';
import 'package:transporter/ui/screens/trips/add_trip.dart';
import 'package:transporter/ui/screens/trips/search_trip.dart';
import 'package:transporter/ui/screens/vechil/add_vechil.dart';
import 'package:transporter/ui/searchloads/search_load.dart';

import '../../../data/data.dart';

class HomeOptionsGrid extends StatelessWidget {
  const HomeOptionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: homeOptions().length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1.5),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            if (homeOptions()[index].id == 4) {
              Navigator.pushNamed(context, PostLoad.name);
            } else if (homeOptions()[index].id == 5) {
              Navigator.pushNamed(context, AddVechil.name);
            } else if (homeOptions()[index].id == 6) {
              Navigator.pushNamed(context, AddTrip.name);
            } else if (homeOptions()[index].id == 7) {
              Navigator.pushNamed(context, SearchLoad.name);
            } else if (homeOptions()[index].id == 9) {
              Navigator.pushNamed(context, SearchTrip.name);
            } else
              Navigator.pushNamed(context, SearchTrip.name);
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  homeOptions()[index].url,
                  height: 80,
                ),
                Text(
                  homeOptions()[index].name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
