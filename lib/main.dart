import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/Admin/AdminHome.dart';
import 'package:service_provider/Screens/Provider/AdditionalInfo.dart';
import 'package:service_provider/Screens/Provider/JobDetails.dart';
import 'package:service_provider/Screens/Provider/Navbar.dart';
import 'package:service_provider/Screens/Provider/ProfilePage.dart';
import 'package:service_provider/Screens/Provider/ProviderLoginScreen.dart';
import 'package:service_provider/Screens/Provider/ProviderSignUpScreen.dart';
import 'package:service_provider/Screens/Provider/HomeProvider.dart';
import 'package:service_provider/Screens/Provider/VerificationProvider.dart';
import 'package:service_provider/Screens/Request/ServiceRequestLocation.dart';
import 'package:service_provider/Screens/User/MyBooks.dart';
import 'package:service_provider/Screens/User/MyFavorateProviders.dart';
import 'package:service_provider/Screens/User/RecommendedProviderMap.dart';
import 'package:service_provider/Screens/User/ServiceDetails.dart';
import 'package:service_provider/Screens/Request/ServiceRequest.dart';
import 'package:service_provider/Screens/User/UserHome.dart';
import 'package:service_provider/Screens/User/UserLoginScreen.dart';
import 'package:service_provider/Screens/User/UserSignUpScreen.dart';
import 'package:service_provider/Screens/User/VerificationUser.dart';
import 'package:service_provider/Screens/commonScreens/ChangeEmail.dart';
import 'package:service_provider/Screens/commonScreens/MyActivity.dart';
import 'package:service_provider/Screens/commonScreens/ResetPassword.dart';
import 'package:service_provider/Screens/commonScreens/SearchScreen.dart';
import 'package:service_provider/Screens/commonScreens/Settings.dart';
import 'package:service_provider/Screens/commonScreens/SplashScreen.dart';
import 'package:service_provider/Screens/Admin/AddServices.dart';
import 'package:service_provider/Screens/Admin/ManageServices.dart';
import 'package:service_provider/Screens/commonScreens/WelcomeScreen.dart';
import 'package:service_provider/Screens/User/ProfilePage.dart';
import 'package:service_provider/Screens/User/RecommendedProviders.dart';
import 'package:service_provider/Screens/commonScreens/testing.dart';
import 'Screens/Provider/ProviderLocation.dart';
import 'Screens/commonScreens/ChangePassword.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MaterialApp(
        theme: ThemeData(
            highlightColor: KprimaryColor, accentColor: KprimaryColor),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.id,
        routes: {
          MyFavorateProviders.id: (context) => MyFavorateProviders(),
          JobDetails.id: (context) => JobDetails(),
          SplashScreen.id: (context) => SplashScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          SearchPage.id: (context) => SearchPage(),
          ServiceRequestLocation.id: (context) => ServiceRequestLocation(),
          UserVerifyScreen.id: (context) => UserVerifyScreen(),
          ProviderVerifyScreen.id: (context) => ProviderVerifyScreen(),
          ServiceDetails.id: (context) => ServiceDetails(),
          ResetPassword.id: (context) => ResetPassword(),
          AdditionalInfo.id: (context) => AdditionalInfo(),
          UserHome.id: (context) => UserHome(),
          ServiceRequest.id: (context) => ServiceRequest(),
          ProviderLocation.id: (context) => ProviderLocation(),
          AddService.id: (context) => AddService(),
          AdminHome.id: (context) => AdminHome(),
          ManageService.id: (context) => ManageService(),
          UserProfilescreen.id: (context) => UserProfilescreen(),
          ProviderProfilescreen.id: (context) => ProviderProfilescreen(),
          RecommendedProviders.id: (context) => RecommendedProviders(),
          MyBooks.id: (context) => MyBooks(),
          UserSignUpScreen.id: (context) => UserSignUpScreen(),
          UserLoginScreen.id: (context) => UserLoginScreen(),
          ProviderLoginScreen.id: (context) => ProviderLoginScreen(),
          ProviderSignUpScreen.id: (context) => ProviderSignUpScreen(),
          MyActivity.id: (context) => MyActivity(),
          HomeProvider.id: (context) => HomeProvider(),
          ChangeEmail.id: (context) => ChangeEmail(),
          ChangePassword.id: (context) => ChangePassword(),
          Navbar.id: (context) => Navbar(),
          Settings.id: (context) => Settings(),
          RecommendedProvidersMap.id: (context) => RecommendedProvidersMap(),
          Testing.id: (context) => Testing(),
        },
      ),
    );
  }
}
