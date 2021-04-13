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

  // ignore: non_constant_identifier_names
  Color _ColorFN, _prefixColorFN = primaryColorDark;
  // ignore: non_constant_identifier_names
  Color _ColorEPN, _prefixColorEPN = primaryColorDark;
  // ignore: non_constant_identifier_names
  Color _ColorPW, _prefixColorPW = primaryColorDark;
  // ignore: non_constant_identifier_names
  Color _ColorCPW, _prefixColorCPW = primaryColorDark;

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
                child: MyCustomTextField(
                    labelText: "Full Name",
                    hintText: "e.g Sam Wilson",
                    prefixIcon: Icons.person,
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: minimumpadding * 1.5, bottom: minimumpadding * 1.5),
              child: Focus(
                child: MyCustomTextField(
                  labelText: "Email / Phone Number",
                  hintText: "example@yourmail.com / +XXX 123456789",
                  prefixIcon: Icons.mail,
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: minimumpadding * 1.5, bottom: minimumpadding * 1.5),
              child: Focus(
                child: MyCustomTextField(
                  labelText: "Password",
                  hintText: "e.g Password",
                  prefixIcon: Icons.vpn_key,
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: minimumpadding * 1.5, bottom: minimumpadding * 1.5),
              child: Focus(
                child: MyCustomTextField(
                  labelText: "Confirm Password",
                  hintText: "Confirm Password",
                  prefixIcon: Icons.vpn_key,
                ),
              ),
            ),



            Container(
              padding: EdgeInsets.only(top: minimumpadding * 3),
              // ignore: deprecated_member_use
              child: MyCustomButton(
                  textValue: "Sign Up",
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