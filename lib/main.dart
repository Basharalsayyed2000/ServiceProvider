import 'package:flutter/material.dart';
import 'Screens/HomeScreen.dart';
main() => runApp(MyApp());

class MyApp extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Home.route,
       routes: {
        Home.route: (context) => Home(),
      },
    );
  }
}