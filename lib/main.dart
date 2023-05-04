import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporter/ui/screens/_home/home_screen.dart';
import 'package:transporter/ui/screens/auth/otp_screen.dart';
import 'package:transporter/ui/screens/auth/register_screen.dart';
import 'package:transporter/ui/screens/loads/my_loads.dart';
import 'package:transporter/ui/screens/loads/post_load.dart';
import 'package:transporter/ui/screens/profile/profile_screen.dart';
import 'package:transporter/ui/screens/trips/add_trip.dart';
import 'package:transporter/ui/screens/trips/my_vechils.dart';
import 'package:transporter/ui/screens/trips/search_trip.dart';
import 'package:transporter/ui/screens/vechil/add_vechil.dart';
import 'package:transporter/ui/searchloads/search_load.dart';
import 'data/provider/user_notifier.dart';
import 'firebase_options.dart';
import 'helpers/appPref.dart';
import 'ui/screens/auth/login_screen.dart';
import 'ui/screens/trips/my_trips.dart';

Future<void> main() async {
  // Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  SharedPrefs.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    Provider<UserProvider>(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transporter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigo[800],
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(),
        ),
        appBarTheme: AppBarTheme(
            iconTheme: const IconThemeData(color: Colors.indigo),
            elevation: 0,
            backgroundColor: Colors.indigo[50]),
        scaffoldBackgroundColor: Colors.indigo[50],
        primarySwatch: Colors.indigo,
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
          border: OutlineInputBorder(),
        ),
      ),
      initialRoute: SharedPrefs.getBool(SharedPrefs.islogin) == true
          ? HomeScreen.name
          : LoginScreen.name,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;

        switch (settings.name) {
          case LoginScreen.name:
            builder = (BuildContext _) => LoginScreen();
            break;
          case RegistrationScreen.name:
            builder = (BuildContext _) => RegistrationScreen();
            break;
          case OtpScreen.name:
            builder =
                (BuildContext _) => OtpScreen(arguements: settings.arguments);
            break;
          case HomeScreen.name:
            builder = (BuildContext _) => HomeScreen();
            break;
          case ProfileScreen.name:
            builder = (BuildContext _) => ProfileScreen();
            break;
          case AddTrip.name:
            builder = (BuildContext _) => AddTrip();
            break;
          case PostLoad.name:
            builder = (BuildContext _) => PostLoad();
            break;
          case AddVechil.name:
            builder = (BuildContext _) => AddVechil();
            break;
          case MyLoadsScreen.name:
            builder = (BuildContext _) => MyLoadsScreen();
            break;
          case MyVechilsScreen.name:
            builder = (BuildContext _) => MyVechilsScreen();
            break;
          case SearchLoad.name:
            builder = (BuildContext _) => SearchLoad();
            break;
          case SearchTrip.name:
            builder = (BuildContext _) => SearchTrip();
            break;
          case MyTripsScreen.name:
            builder = (BuildContext _) => MyTripsScreen();
            break;

          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
