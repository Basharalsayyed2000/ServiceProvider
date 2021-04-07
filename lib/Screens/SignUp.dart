import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';

class SignUpScreen extends StatefulWidget{

  static String id = 'signUpScreen';

  @override
  State<StatefulWidget> createState(){
    return _SignUpScreen();
  }
}

class _SignUpScreen extends State<SignUpScreen>{

  final _height = 75.0;

  Color _colorFN, _prefixColorFN = primaryColorDark;
  Color _colorEPN, _prefixColorEPN = primaryColorDark;
  Color _colorPW, _prefixColorPW = primaryColorDark;
  Color _colorCPW, _prefixColorCPW = primaryColorDark;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: minimumpadding * 2, bottom: minimumpadding * 2, left: minimumpadding * 4.5, right: minimumpadding * 4.5),
        child: ListView(
          children: <Widget>[
            //getImage(),

            Container(
              height: _height,
              padding: EdgeInsets.only(top: minimumpadding * 2, bottom: minimumpadding * 2),
              child: Focus(
                onFocusChange: (hasFocus){
                  setState(() {
                    _colorFN = hasFocus ? focusColor : null;
                    _prefixColorFN = hasFocus ? focusColor : primaryColorDark;
                  });
                },
                child: TextField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    labelStyle: TextStyle(
                      color: _colorFN,
                    ),
                    hintText: "e.g Sam Wilson",
                    prefixIcon: Icon(Icons.person, color: _prefixColorFN),

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: accentColor, width: 1.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: focusColor, width: 2.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),

                  ),
                ),
              ),
            ),

            Container(
              height: _height,
              padding: EdgeInsets.only(top: minimumpadding * 2, bottom: minimumpadding * 2),
              child: Focus(
                onFocusChange: (hasFocus){
                  setState(() {
                    _colorEPN = hasFocus ? focusColor : null;
                    _prefixColorEPN = hasFocus ? focusColor : primaryColorDark;
                  });
                },
                child: TextField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "Email / Phone Number",
                    labelStyle: TextStyle(
                        color: _colorEPN
                    ),
                    hintText: "example@yourmail.com / +XXX 123456789",
                    prefixIcon: Icon(Icons.mail, color: _prefixColorEPN),

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: disabledColor, width: 1.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 2.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),

                  ),
                ),
              ),
            ),

            Container(
              height: _height,
              padding: EdgeInsets.only(top: minimumpadding * 2, bottom: minimumpadding * 2),
              child: Focus(
                onFocusChange: (hasFocus){
                  setState(() {
                    _colorPW = hasFocus ? focusColor : null;
                    _prefixColorPW = hasFocus ? focusColor : primaryColorDark;
                  });
                },
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                        color: _colorPW
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
                ),
              ),
            ),

            Container(
              height: _height,
              padding: EdgeInsets.only(top: minimumpadding * 2, bottom: minimumpadding * 2),
              child: Focus(
                onFocusChange: (hasFocus){
                  setState(() {
                    _colorCPW = hasFocus ? focusColor : null;
                    _prefixColorCPW = hasFocus ? focusColor : primaryColorDark;
                  });
                },
                child: TextField(

                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(
                        color: _colorCPW
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
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: minimumpadding * 3),
              child: RaisedButton(
                  padding: EdgeInsets.all(minimumpadding*1.5),
                  elevation: 4.0,
                  color: Color.fromRGBO(157, 215, 211, 1),

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: accentColor,)
                  ),

                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
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
                      color: primaryColorDark,
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
    AssetImage assetImage = new AssetImage("lib/images/Logo.png");
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