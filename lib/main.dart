import 'package:flutter/material.dart';
import 'package:service_provider/Screens/SignUp.dart';
import 'package:service_provider/Screens/login.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.id,
       routes: {
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id:(context)=>SignUpScreen(),
      },
    );
  }
}