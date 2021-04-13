import 'package:flutter/material.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyTools/Constant.dart';

class SignUpScreen extends StatefulWidget{

  static String id = 'signUpScreen';

  @override
  State<StatefulWidget> createState(){
    return _SignUpScreen();
  }
}

class _SignUpScreen extends State<SignUpScreen>{

<<<<<<< Updated upstream:lib/Screens/SignUp.dart
=======
  final _minimumpadding = 5.0;
  final _height = 75.0;

  // ignore: non_constant_identifier_names
  Color _ColorFN, _prefixColorFN = KprimaryColorDark;
  // ignore: non_constant_identifier_names
  Color _ColorEPN, _prefixColorEPN = KprimaryColorDark;
  // ignore: non_constant_identifier_names
  Color _ColorPW, _prefixColorPW = KprimaryColorDark;
  // ignore: non_constant_identifier_names
  Color _ColorCPW, _prefixColorCPW = KprimaryColorDark;

>>>>>>> Stashed changes:lib/Screens/SignUpScreen.dart
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: minimumpadding*2, bottom: minimumpadding*2, left: minimumpadding*4.5, right: minimumpadding*4.5),
        child: ListView(
          children: <Widget>[
            getImage(),

            Container(
              padding: EdgeInsets.only(top: minimumpadding * 1.5, bottom: minimumpadding * 1.5),
              child: Focus(
<<<<<<< Updated upstream:lib/Screens/SignUp.dart
                child: CustomTextField(
=======
                onFocusChange: (hasFocus){
                  setState(() {
                    _ColorFN = hasFocus ? focusColor : null;
                    _prefixColorFN = hasFocus ? focusColor : KprimaryColorDark;
                  });
                },
                child: TextField(
                  autofocus: false,
                  decoration: InputDecoration(
>>>>>>> Stashed changes:lib/Screens/SignUpScreen.dart
                    labelText: "Full Name",
                    hintText: "e.g Sam Wilson",
<<<<<<< Updated upstream:lib/Screens/SignUp.dart
                    prefixIcon: Icons.person,
=======
                    prefixIcon: Icon(Icons.person, color: _prefixColorFN),

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: KaccentColor, width: 1.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: focusColor, width: 2.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),

                  ),
>>>>>>> Stashed changes:lib/Screens/SignUpScreen.dart
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: minimumpadding * 1.5, bottom: minimumpadding * 1.5),
              child: Focus(
<<<<<<< Updated upstream:lib/Screens/SignUp.dart
                child: CustomTextField(
                  labelText: "Email / Phone Number",
                  hintText: "example@yourmail.com / +XXX 123456789",
                  prefixIcon: Icons.mail,
=======
                onFocusChange: (hasFocus){
                  setState(() {
                    _ColorEPN = hasFocus ? focusColor : null;
                    _prefixColorEPN = hasFocus ? focusColor : KprimaryColorDark;
                  });
                },
                child: TextField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "Email / Phone Number",
                    labelStyle: TextStyle(
                        color: _ColorEPN
                    ),
                    hintText: "example@yourmail.com / +XXX 123456789",
                    prefixIcon: Icon(Icons.mail, color: _prefixColorEPN),

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: disabledColor, width: 1.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: KprimaryColor, width: 2.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),

                  ),
>>>>>>> Stashed changes:lib/Screens/SignUpScreen.dart
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: minimumpadding * 1.5, bottom: minimumpadding * 1.5),
              child: Focus(
<<<<<<< Updated upstream:lib/Screens/SignUp.dart
                child: CustomTextField(
                  labelText: "Password",
                  hintText: "e.g Password",
                  prefixIcon: Icons.vpn_key,
=======
                onFocusChange: (hasFocus){
                  setState(() {
                    _ColorPW = hasFocus ? focusColor : null;
                    _prefixColorPW = hasFocus ? focusColor : KprimaryColorDark;
                  });
                },
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                        color: _ColorPW
                    ),
                    hintText: "e.g Password",
                    prefixIcon: Icon(Icons.vpn_key, color: _prefixColorPW),

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: disabledColor, width: 1.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: focusColor, width: 2.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),

                  ),
>>>>>>> Stashed changes:lib/Screens/SignUpScreen.dart
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: minimumpadding * 1.5, bottom: minimumpadding * 1.5),
              child: Focus(
<<<<<<< Updated upstream:lib/Screens/SignUp.dart
                child: CustomTextField(
                  labelText: "Confirm Password",
                  hintText: "Confirm Password",
                  prefixIcon: Icons.vpn_key,
=======
                onFocusChange: (hasFocus){
                  setState(() {
                    _ColorCPW = hasFocus ? focusColor : null;
                    _prefixColorCPW = hasFocus ? focusColor : KprimaryColorDark;
                  });
                },
                child: TextField(

                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(
                        color: _ColorCPW
                    ),
                    hintText: "Confirm Password",
                    prefixIcon: Icon(Icons.vpn_key, color: _prefixColorCPW),

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: disabledColor, width: 1.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: focusColor, width: 2.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),

                  ),
>>>>>>> Stashed changes:lib/Screens/SignUpScreen.dart
                ),
              ),
            ),



            Container(
              padding: EdgeInsets.only(top: minimumpadding * 3),
              // ignore: deprecated_member_use
<<<<<<< Updated upstream:lib/Screens/SignUp.dart
              child: CustomButton(
                  textValue: "Sign Up",
=======
              child: RaisedButton(
                  padding: EdgeInsets.all(_minimumpadding*1.5),
                  elevation: 4.0,
                  color: Color.fromRGBO(157, 215, 211, 1),

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: KaccentColor,)
                  ),

                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
>>>>>>> Stashed changes:lib/Screens/SignUpScreen.dart
                  onPressed: (){

                  }
              ),
            ),

            Center(
              child: Container(
                padding: EdgeInsets.only(top: minimumpadding*6),
                child: Text(
                  "Already have an account? Sign in",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: KprimaryColorDark,
                      decoration: TextDecoration.underline
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  void updateOnFocus(FocusNode focusNode, Color color){
    setState(() {
      focusNode.addListener(() {
        if(focusNode.hasFocus){
          print("is focused");
          color = focusColor;
        }else
          color = Colors.yellowAccent;
      });
    });

  }

  Widget getImage(){
    AssetImage assetImage = new AssetImage("Assets/images/Logo.png");
    Image image = new Image(image: assetImage);
    return Padding(
      padding: EdgeInsets.all(minimumpadding),
      child: Container(
        padding: EdgeInsets.all(minimumpadding),
        width: 200.0,
        height: 200.0,
        child: image,
      ),
    );
  }

}