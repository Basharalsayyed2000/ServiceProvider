import 'package:flutter/material.dart';
import 'package:service_provider/Screens/Admin/AdminHome.dart';
import 'package:service_provider/Screens/Provider/AdditionalInfo.dart';
import 'package:service_provider/Screens/Provider/JobDetails.dart';
import 'package:service_provider/Screens/Provider/ProviderHome.dart';
import 'package:service_provider/Screens/Provider/ProviderLoginScreen.dart';
import 'package:service_provider/Screens/Provider/ProviderSignUpScreen.dart';
import 'package:service_provider/Screens/Provider/HomeProvider.dart';
import 'package:service_provider/Screens/Provider/RecommendedJobs.dart';
import 'package:service_provider/Screens/Provider/VerificationProvider.dart';
import 'package:service_provider/Screens/Request/ServiceRequestLocation.dart';
import 'package:service_provider/Screens/User/MyBooks.dart';
import 'package:service_provider/Screens/Request/RequestComponent.dart';
import 'package:service_provider/Screens/User/MyFavorateProviders.dart';
import 'package:service_provider/Screens/User/ServiceDetails.dart';
import 'package:service_provider/Screens/Request/ServiceRequest.dart';
import 'package:service_provider/Screens/User/UserHome.dart';
import 'package:service_provider/Screens/User/UserLoginScreen.dart';
import 'package:service_provider/Screens/User/UserSignUpScreen.dart';
import 'package:service_provider/Screens/User/VerificationUser.dart';
import 'package:service_provider/Screens/commonScreens/MyActivity.dart';
import 'package:service_provider/Screens/commonScreens/ResetPassword.dart';
import 'package:service_provider/Screens/commonScreens/SplashScreen.dart';
import 'package:service_provider/Screens/Admin/AddServices.dart';
import 'package:service_provider/Screens/Admin/ManageServices.dart';
import 'package:service_provider/Screens/commonScreens/WelcomeScreen.dart';
import 'package:service_provider/Screens/User/ProfilePage.dart';
import 'package:service_provider/Screens/User/RecommendedProviders.dart';
import 'Screens/Provider/ProviderLocation.dart';
import 'Screens/Provider/ProviderHome.dart';
main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeProvider.id,
      routes: {
        MyFavorateProviders.id: (context) => MyFavorateProviders(),
        JobDetails.id: (context) => JobDetails(),
        SplashScreen.id: (context) => SplashScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ServiceRequestLocation.id :(context)=>ServiceRequestLocation(),
        UserVerifyScreen.id: (context) => UserVerifyScreen(),
        ProviderVerifyScreen.id: (context) => ProviderVerifyScreen(),
        RequestComponent.id: (context) => RequestComponent(),
        ServiceDetails.id: (context) => ServiceDetails(),
        ResetPassword.id: (context) => ResetPassword(),
        AdditionalInfo.id: (context) => AdditionalInfo(),
        ProviderHome.id: (context) => ProviderHome(),
        UserHome.id: (context) => UserHome(),
        ServiceRequest.id: (context) => ServiceRequest(),
        ProviderLocation.id: (context) => ProviderLocation(),
        AddService.id: (context) => AddService(),
        AdminHome.id: (context) => AdminHome(),
        ManageService.id: (context) => ManageService(),
        UserProfilescreen.id: (context) => UserProfilescreen(),
        RecommendedProviders.id: (context) => RecommendedProviders(),
        MyBooks.id: (context) => MyBooks(),
        UserSignUpScreen.id: (context) => UserSignUpScreen(),
        UserLoginScreen.id: (context) => UserLoginScreen(),
        ProviderLoginScreen.id: (context) => ProviderLoginScreen(),
        ProviderSignUpScreen.id: (context) => ProviderSignUpScreen(),
        RecommendedJobs.id: (context) => RecommendedJobs(),
        MyActivity.id: (context) => MyActivity(),
        HomeProvider.id: (context) => HomeProvider(),
        

      //  SearchScreen.id: (context) => SearchScreen(),

        
      },
    );
  }
}
