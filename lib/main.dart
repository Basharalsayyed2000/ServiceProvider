import 'package:flutter/material.dart';
import 'package:service_provider/Screens/Admin/AdminHome.dart';
import 'package:service_provider/Screens/User/UserHome.dart';
import 'package:service_provider/Screens/commonScreens/SignUpScreen.dart';
import 'package:service_provider/Screens/commonScreens/LoginScreen.dart';
import 'package:service_provider/Screens/commonScreens/SplashScreen.dart';
import 'package:service_provider/Screens/User/ServiceRequest.dart';
import 'package:service_provider/Screens/Admin/AddServices.dart';
import 'package:service_provider/Screens/Admin/ManageServices.dart';
import 'package:service_provider/Screens/commonScreens/WelcomeScreen.dart';
import 'package:service_provider/Screens/User/ProfilePage.dart';
import 'package:service_provider/Screens/User/RecommendedProviders.dart';

import 'Screens/User/ServiceRequestLocation.dart';

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
        UserHome.id: (context) => UserHome(),
        SignUpScreen.id: (context) => SignUpScreen(),
        ServiceRequest.id: (context) => ServiceRequest(),
        ServiceRequestLocation.id: (context) => ServiceRequestLocation(),
        AddService.id: (context) => AddService(),
        AdminHome.id: (context) => AdminHome(),    
        WelcomeScreen.id: (context)=>WelcomeScreen(), 
        ManageService.id: (context) => ManageService(),
        Profilescreen.id: (context) => Profilescreen(),
        Recommended.id: (context) => Recommended(),       
      },
    );
  }
}
