import 'package:flutter/material.dart';
import 'package:service_provider/Screens/commonScreens/LoginScreen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'WelcomeScreen';
  @override
  _WelcomeScreen createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
   bool _isUser= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25.0,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Container(
                padding: EdgeInsets.all(2),
                width: MediaQuery.of(context).size.height * 0.6,
                height: MediaQuery.of(context).size.width * 0.65,
                child: Image.asset("Assets/images/Logo.png"),
              ),
            ),
          ),
          SizedBox(height: 65,),
          Container(
            child: Column(
              children: [
                Center(
                    child: Text(
                  "Welcome!",
                  style: TextStyle(
                      color: Color.fromRGBO(79, 194, 185, 1),
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold),
                )),
                Center(
                    child: Text(
                  "We're glad you're here",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ))
              ],
            ),
          ),
          SizedBox(
            height: 70,
          ),
         
          Expanded(
            
              child: GridView.count(
              
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            primary: false,
            children: [
              GestureDetector(
                
                onTap: () {
                  setState(() {
                    _isUser=true;
                    Navigator.of(context).pushReplacementNamed(LoginScreen.id,arguments: _isUser);
                  });
                },
                child: Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "Assets/images/user.jpg",
                        height: 130,
                      ),
                      Text(
                        "User",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                   setState(() {
                    _isUser=false;
                    Navigator.of(context).pushReplacementNamed(LoginScreen.id,arguments: _isUser);
                  });
                },
                child: Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "Assets/images/provider.jpg",
                        height: 130,
                        width: 100,
                      ),
                      Text(
                        "Provider",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
