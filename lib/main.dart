import 'package:flutter/material.dart';
import 'package:service_provider/Screens/SignUp.dart';
import 'package:service_provider/Screens/Login.dart';
import 'package:service_provider/Screens/SplashScreen.dart';
import 'package:service_provider/Screens/User/ServiceRequest.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: ServiceRequest.id,
       routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id:(context)=>SignUpScreen(),
        ServiceRequest.id:(context)=>ServiceRequest(),
      },
    );
  }
}