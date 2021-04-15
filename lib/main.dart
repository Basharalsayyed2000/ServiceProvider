import 'package:flutter/material.dart';
import 'package:service_provider/Screens/Admin/AdminHome.dart';
import 'package:service_provider/Screens/commonScreens/SignUpScreen.dart';
import 'package:service_provider/Screens/commonScreens/LoginScreen.dart';
import 'package:service_provider/Screens/commonScreens/SplashScreen.dart';
import 'package:service_provider/Screens/User/ServiceRequest.dart';
import 'package:service_provider/Screens/Admin/AddServices.dart';
import 'package:service_provider/Screens/Admin/ManageServices.dart';
import 'package:service_provider/Screens/User/UserHome.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        Providerscreen.id: (context) => Providerscreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        ServiceRequest.id: (context) => ServiceRequest(),
        AddService.id: (context) => AddService(),
        AdminHome.id: (context) => AdminHome(),
        ManageService.id: (context) => ManageService(),
      },
    );
  }
}
