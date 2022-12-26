import 'package:flutter/material.dart';
import 'package:transporter/ui/screens/profile/profile_screen.dart';

import '../../../data/data.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(children: [
        Container(
          width: double.infinity,
          height: 250,
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: const [
              CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsqyxQqOtTiZSQ4h9suui5aumtqQakPDkmE80XrEg&s")),
              SizedBox(height: 15),
              Text(
                'Mahesh Mallem',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '+91 7032214460',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        Expanded(
            child: ListView.separated(
                padding: EdgeInsets.all(6),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: homeMenu().length,
                itemBuilder: ((context, index) => ListTile(
                    onTap: (() {
                      print("ON CLICK");
                      switch (index) {
                        case 0:
                          Navigator.pushNamed(context, ProfileScreen.name);
                          Navigator.pop(context);
                          break;
                        default:
                      }
                    }),
                    leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          homeMenu()[index].url,
                        )),
                    title: Text(
                      homeMenu()[index].name,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )))))
      ]),
    );
  }
}
