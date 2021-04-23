import 'package:flutter/material.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/Provider/ProviderHome.dart';
import 'package:service_provider/Screens/commonScreens/SignUpScreen.dart';
import 'package:service_provider/Services/auth.dart';
import 'package:service_provider/Screens/User/UserHome.dart';
import 'package:service_provider/Services/user.dart';
// ignore: unused_import

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  // ignore: unused_field
  String _email, _password;
  // ignore: unused_field
  final _auth = Auth();
  // ignore: unused_field
  final _user = UserStore();
  bool isAdmin = false;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    bool _usertype = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:  Form(
          key: _globalKey,
          child:  ListView(
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
                Container(
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
                        height: MediaQuery.of(context).size.height * 0.0305,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.height * 0.4505,
                        child: CustomButton(
                          textValue: "LOGIN",
                          onPressed: () async {
                           
                            if (_globalKey.currentState.validate()) {
                              _globalKey.currentState.save();
                              // ignore: unused_local_variable
                              String message = '';
                              try {
                                // ignore: unused_local_variable
                                final _authresult = await _auth.signIn(
                                    _email.trim(), _password.trim());
                                if(_usertype==true){    
                                Navigator.pushReplacementNamed(
                                    context, UserHome.id,
                                    arguments: _authresult.user.uid);
                                }
                                else{
                                   Navigator.pushReplacementNamed(
                                    context, ProviderHome.id,
                                    arguments: _authresult.user.uid);
                                }
                              } catch (e) {
                                // ignore: deprecated_member_use
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(e.toString()),
                                ));
                                print(e.message);
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
                        Navigator.pushReplacementNamed(context, SignUpScreen.id,
                            arguments: _usertype);
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
          ),  
    );
  }

  void toggleProgressHUD(_loading, _progressHUD) {
    setState(() {
      if (_loading) {
        _progressHUD.show();
      } else {
        _progressHUD.dismiss();
      }
    });
  }
}
