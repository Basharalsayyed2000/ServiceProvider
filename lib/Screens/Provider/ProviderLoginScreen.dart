import 'package:flutter/material.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/Provider/ProviderHome.dart';
import 'package:service_provider/Screens/Provider/ProviderSignUpScreen.dart';
import 'package:service_provider/Services/auth.dart';
import 'package:service_provider/Services/user.dart';

class ProviderLoginScreen extends StatefulWidget {
  static String id = 'ProviderLoginScreen';

  @override
  _ProviderLoginScreen createState() => _ProviderLoginScreen();
}

class _ProviderLoginScreen extends State<ProviderLoginScreen> {
  String _email, _password;
  final _auth = Auth();
  final userStore = UserStore();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0185,
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
          Form(
            key: _globalKey,
            child: Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: Kminimumpadding * 1.5,
                        bottom: Kminimumpadding * 1.5),
                    child: Focus(
                      child: CustomTextField(
                        labelText: "Email",
                        hintText: "example@gmail.com",
                        prefixIcon: Icons.person,
                        onClicked: (value) {
                          _email = value;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0015,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: Kminimumpadding * 1.5,
                        bottom: Kminimumpadding * 1.5),
                    child: Focus(
                      child: CustomTextField(
                        labelText: "Password",
                        hintText: "e.g Password",
                        prefixIcon: Icons.vpn_key,
                        obscureText: true,
                        onClicked: (value) {
                          _password = value;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                 GestureDetector (
                                      child: Container(
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
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0305,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.height * 0.4505,
                    child: CustomButton(
                      textValue: "LOGIN",
                      onPressed: () async {
                        if (_globalKey.currentState.validate()) {
                          _globalKey.currentState.save();
                          try {
                            final _authresult = await _auth.signIn(
                                _email.trim(), _password.trim());

                          
                              Navigator.pushNamedAndRemoveUntil(
                                  context, ProviderHome.id,(route)=>false,
                                  arguments: _authresult.user.uid);
              
                          } catch (e) {
                            
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0485,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset(
                              "Assets/images/google-symbol.png",
                              height: 25,
                            ),
                          )),
                      Material(
                        elevation: 5,
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
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset(
                              "Assets/images/twitter-4.png",
                              height: 25,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0485,
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
                onTap: () {
                  Navigator.pushReplacementNamed(context, ProviderSignUpScreen.id,
                  );
                },
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
