import 'dart:async';
import 'package:flutter/material.dart';
import 'package:service_provider/Screens/SignUp.dart';

class SplashScreen extends StatefulWidget{
  static String id = 'splashScreen';
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen>{
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4),
        ()=>Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => SignUpScreen()
          )
        )
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Container(
         child: Text("Hello World"),
         // child: getLogo(),
        ),
      ),
    );
  }

  /*Widget getLogo(){
    AssetImage assetImage = new AssetImage("lib/MyTools/images/Logo.png");
    return Image(image: assetImage);
  }*/

}