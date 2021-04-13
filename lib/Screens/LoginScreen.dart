import 'package:flutter/material.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyTools/Constant.dart';
// ignore: unused_import


class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
       
        children: <Widget>[
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
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                Container(
              padding: EdgeInsets.only(top: Kminimumpadding * 1.5, bottom: Kminimumpadding * 1.5),
              child: Focus(
                child: CustomTextField(
                    labelText: "Name",
                    hintText: "e.g Sam Wilson",
                    prefixIcon: Icons.person, onClicked: null,
                ),
              ),
            ),
                SizedBox(
                  height: 30.0,
                ),
               Container(
              padding: EdgeInsets.only(top: Kminimumpadding * 1.5, bottom: Kminimumpadding * 1.5),
              child: Focus(
                child: CustomTextField(
                  labelText: "Password",
                  hintText: "e.g Password",
                  prefixIcon: Icons.vpn_key, onClicked: null,
                ),
              ),
            ),

                SizedBox(
                  height: 2.0,
                ),
                Container(
                  alignment: Alignment(0.8, 0.0),
                  padding: EdgeInsets.only(top: 15.0, left: 20.0),
                  child: InkWell(
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Color.fromRGBO(24, 48, 48, 1),
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat",
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.black,
                    color: Color.fromRGBO(157, 215, 211, 1),
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat"),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            "Assets/images/google-symbol.png",
                            height: 25,
                          ),
                        )),

                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset(
                          "Assets/images/fblogo5.png",
                          height: 25,
                        ),
                      ),
                    ),
                    Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            "Assets/images/twitter-4.png",
                            height: 25,
                          ),
                        ))
                    //  ImageIcon(AssetImage("assets/fblogo4.png")),
                    //  ImageIcon(AssetImage("assets/fblogo4.png")),
                    //  ImageIcon(AssetImage("assets/fblogo4.png"))
                    // Container(
                    //   height: 40,
                    //   color: Colors.transparent,
                    //   child: Container(
                    //      height: 100,
                    //     width: 100,
                    //     decoration: BoxDecoration(
                    //       border: Border.all(
                    //         color: Colors.black,
                    //         style: BorderStyle.solid,
                    //         width: 1.0
                    //       ),
                    //       color: Colors.transparent,
                    //       shape: BoxShape.circle
                    //     ),
                    //     child:ImageIcon(AssetImage("assets/fblogo4.png")) ,
                    //   ),
                    // ),
                    // Container(
                    //   height: 40,
                    //   color: Colors.transparent,
                    //   child: Container(
                    //      height: 100,
                    //     width: 100,
                    //     decoration: BoxDecoration(
                    //       border: Border.all(
                    //         color: Colors.black,
                    //         style: BorderStyle.solid,
                    //         width: 1.0
                    //       ),
                    //       color: Colors.transparent,
                    //       shape: BoxShape.circle
                    //     ),
                    //     child:ImageIcon(AssetImage("assets/google.png")) ,
                    //   ),
                    // ),
                    // Container(
                    //   height: 40,
                    //   color: Colors.transparent,
                    //   child: Container(
                    //     height: 100,
                    //     width: 100,
                    //     decoration: BoxDecoration(
                    //       border: Border.all(
                    //         color: Colors.black,
                    //         style: BorderStyle.solid,
                    //         width: 1.0,

                    //       ),
                    //       color: Colors.transparent,
                    //       //borderRadius: BorderRadius.circular(40)
                    //       shape: BoxShape.circle
                    //     ),
                    //     child:ImageIcon(AssetImage("assets/fblogo4.png")) ,
                    //   ),
                    // )
                  ],
                ),
                // Container(
                //   height: 40.0,
                //   color: Colors.transparent,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         color:Colors.black,
                //         style:BorderStyle.solid,
                //         width: 1.0,
                //       ),
                //       color: Colors.transparent,
                //       borderRadius: BorderRadius.circular(20.0)
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children:<Widget> [
                //       Center(
                //         child: ImageIcon(AssetImage("assets/fblogo4.png")),
                //       ),
                //       SizedBox(height: 10.0,),
                //       Center(
                //        child: Text("Log in with facebook",
                //        style: TextStyle(
                //          fontWeight: FontWeight.bold,
                //          fontFamily: "Montserrat"
                //        ),),
                //       )
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          SizedBox(
            height: 45.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Don't have an account?",
                style: TextStyle(),
              ),
              SizedBox(width: 5.0),
              InkWell(
                onTap: () {},
                child: Text(
                  "Register",
                  style: TextStyle(
                      color: Color.fromRGBO(24, 48, 48, 1),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
