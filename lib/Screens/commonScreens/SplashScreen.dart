import 'dart:async';
import 'package:flutter/material.dart';
import 'package:service_provider/Screens/Provider/Navbar.dart';
import 'package:service_provider/Screens/User/UserHome.dart';
import 'package:service_provider/Screens/commonScreens/WelcomeScreen.dart';
import 'package:service_provider/Services/auth.dart';

class SplashScreen extends StatefulWidget{
  static String id = 'splashScreen';
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen>{
  bool _isLoggedIn = false, _asUser = true;

  Auth _auth = new Auth();

  @override
  void initState() {

    _auth.isUserLoggedIn().then((isLog) => setState((){
        _isLoggedIn = isLog;
        
        if(_isLoggedIn){
          _auth.getCurrentUserId().then((uid) => setState((){
            print(uid);
              _auth.checkUserExist(uid).then((isUser) => setState((){
                  _asUser = isUser;
                })
              );
            })
          );
        }
          
      })

    );

    //print(_asUser);

    super.initState();
    Timer(Duration(seconds: 4),
        ()=>Navigator.pushReplacement(context,
          MaterialPageRoute(
              builder: (context) => (!_isLoggedIn) ? WelcomeScreen() : ((_asUser) ? UserHome() : Navbar()),
          )
        )
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
         child: getLogo(),
        ),
      ),
    );
  }

  Widget getLogo(){
    AssetImage assetImage = new AssetImage("Assets/images/Logo.png");
    return Image(image: assetImage);
  }

}