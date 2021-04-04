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

  final _minimumpadding = 5.0;
  final _height = 75.0;

  Color _ColorFN, _prefixColorFN = primaryColorDark;
  Color _ColorEPN, _prefixColorEPN = primaryColorDark;
  Color _ColorPW, _prefixColorPW = primaryColorDark;
  Color _ColorCPW, _prefixColorCPW = primaryColorDark;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: _minimumpadding*2, bottom: _minimumpadding*2, left: _minimumpadding*4.5, right: _minimumpadding*4.5),
        child: ListView(
          children: <Widget>[
            getImage(),

            Container(
              height: _height,
              padding: EdgeInsets.only(top: _minimumpadding * 2, bottom: _minimumpadding * 2),
              child: Focus(
                onFocusChange: (hasFocus){
                  setState(() {
                    _ColorFN = hasFocus ? focusColor : null;
                    _prefixColorFN = hasFocus ? focusColor : primaryColorDark;
                  });
                },
                child: TextField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    labelStyle: TextStyle(
                      color: _ColorFN,
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
              padding: EdgeInsets.only(top: _minimumpadding * 2, bottom: _minimumpadding * 2),
              child: Focus(
                onFocusChange: (hasFocus){
                  setState(() {
                    _ColorEPN = hasFocus ? focusColor : null;
                    _prefixColorEPN = hasFocus ? focusColor : primaryColorDark;
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
                      borderSide: BorderSide(color: primaryColor, width: 2.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),

                  ),
                ),
              ),
            ),

            Container(
              height: _height,
              padding: EdgeInsets.only(top: _minimumpadding * 2, bottom: _minimumpadding * 2),
              child: Focus(
                onFocusChange: (hasFocus){
                  setState(() {
                    _ColorPW = hasFocus ? focusColor : null;
                    _prefixColorPW = hasFocus ? focusColor : primaryColorDark;
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
                ),
              ),
            ),

            Container(
              height: _height,
              padding: EdgeInsets.only(top: _minimumpadding * 2, bottom: _minimumpadding * 2),
              child: Focus(
                onFocusChange: (hasFocus){
                  setState(() {
                    _ColorCPW = hasFocus ? focusColor : null;
                    _prefixColorCPW = hasFocus ? focusColor : primaryColorDark;
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
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: _minimumpadding * 3),
              child: RaisedButton(
                  padding: EdgeInsets.all(_minimumpadding*1.5),
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
                padding: EdgeInsets.only(top: _minimumpadding*6),
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
      padding: EdgeInsets.all(_minimumpadding),
      child: Container(
        padding: EdgeInsets.all(_minimumpadding),
        width: 200.0,
        height: 200.0,
        child: image,
      ),
    );
  }

}