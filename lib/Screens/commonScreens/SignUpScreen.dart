import 'package:flutter/material.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/commonScreens/LoginScreen.dart';
import 'package:service_provider/Services/auth.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'signUpScreen';

  @override
  State<StatefulWidget> createState() {
    return _SignUpScreen();
  }
}

class _SignUpScreen extends State<SignUpScreen> {
  // ignore: unused_field
  String _email, _password, _name;
  // ignore: unused_field
  final _auth = Auth();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            top: Kminimumpadding * 2,
            bottom: Kminimumpadding * 2,
            left: Kminimumpadding * 4.5,
            right: Kminimumpadding * 4.5),
        child: Form(
          key: _globalKey,
          child: ListView(
            children: <Widget>[
              getImage(),
              Container(
                padding: EdgeInsets.only(
                    top: Kminimumpadding * 1.5, bottom: Kminimumpadding * 1.5),
                child: Focus(
                  child: CustomTextField(
                    labelText: "Full Name",
                    hintText: "e.g Sam Wilson",
                    prefixIcon: Icons.person,
                    onClicked: (value) {
                      _name = value;
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: Kminimumpadding * 1.5, bottom: Kminimumpadding * 1.5),
                child: Focus(
                  child: CustomTextField(
                    labelText: "Email / Phone Number",
                    hintText: "example@yourmail.com / +XXX 123456789",
                    prefixIcon: Icons.mail,
                    onClicked: (value) {
                      _email = value;
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: Kminimumpadding * 1.5, bottom: Kminimumpadding * 1.5),
                child: Focus(
                  child: CustomTextField(
                    labelText: "Password",
                    hintText: "e.g Password",
                    prefixIcon: Icons.vpn_key,
                    onClicked: (value) {
                      _password = value;
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: Kminimumpadding * 1.5, bottom: Kminimumpadding * 1.5),
                child: Focus(
                  child: CustomTextField(
                    labelText: "Confirm Password",
                    hintText: "Confirm Password",
                    prefixIcon: Icons.vpn_key,
                    onClicked: (value) {
                      _password = value;
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: Kminimumpadding * 3),
                // ignore: deprecated_member_use
                child: CustomButton(
                  textValue: "Sign Up",
                  onPressed: () async {
                    if (_globalKey.currentState.validate()) {
                      _globalKey.currentState.save();
                      print(_email);
                      print(_password);
                     try{
                        await _auth.signUp(_email.trim(), _password.trim());
                        Navigator.pushNamed(context, LoginScreen.id);
                     }catch(e){
                         print(e);
                     }

                    }
                  },
                ),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: Kminimumpadding * 6),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Text(
                      "Already have an account? Sign in",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: KprimaryColorDark,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateOnFocus(FocusNode focusNode, Color color) {
    setState(() {
      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          print("is focused");
          color = KfocusColor;
        } else
          color = Colors.yellowAccent;
      });
    });
  }

  Widget getImage() {
    AssetImage assetImage = new AssetImage("Assets/images/Logo.png");
    Image image = new Image(image: assetImage);
    return Padding(
      padding: EdgeInsets.all(Kminimumpadding),
      child: Container(
        padding: EdgeInsets.all(Kminimumpadding),
        width: 200.0,
        height: 200.0,
        child: image,
      ),
    );
  }
}
