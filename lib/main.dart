import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:transporter/ui/screens/_home/home_screen.dart';
import 'package:transporter/ui/screens/auth/otp_screen.dart';
import 'package:transporter/ui/screens/auth/register_screen.dart';
import 'package:transporter/ui/screens/profile/profile_screen.dart';
import 'firebase_options.dart';
import 'ui/screens/auth/login_screen.dart';

Future<void> main() async {
  // Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
          // contentPadding: EdgeInsets.symmetric(
          //   vertical: 22,
          //   horizontal: 26,
          // ),
          // labelStyle: TextStyle(
          //   fontSize: 35,
          //   decorationColor: Colors.red,
          // ),
        ),
      ),
      initialRoute: LoginScreen.name,
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
            builder = (BuildContext _) =>
                OtpScreen(mobileNumber: settings.arguments.toString());
            break;
          case HomeScreen.name:
            builder = (BuildContext _) => HomeScreen();
            break;
          case ProfileScreen.name:
            builder = (BuildContext _) => ProfileScreen();
            break;
          default:
            throw new Exception('Invalid route: ${settings.name}');
        }
        return new MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
