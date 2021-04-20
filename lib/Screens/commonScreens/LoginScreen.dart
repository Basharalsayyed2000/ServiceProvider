import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/MyTools/Constant.dart';
// ignore: unused_import
import 'package:service_provider/Screens/Admin/AdminHome.dart';
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
  final _user = User();
  bool isAdmin = false;
  final adminpass = 'admin1234';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    bool _usertype = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ProgressHUD(
        child: Form(
          key: _globalKey,
          child: ListView(
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
                      height: 40.0,
                      child: Builder(
                        builder: (context) => Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.black,
                          color: Color.fromRGBO(157, 215, 211, 1),
                          elevation: 2.0,
                          child: GestureDetector(
                            onTap: () async {
                              final progress = ProgressHUD.of(context);
                              toggleProgressHUD(true, progress);
                              if (_globalKey.currentState.validate()) {
                                _globalKey.currentState.save();
                                // ignore: unused_local_variable
                                String message = '';
                                try {
                                  // ignore: unused_local_variable
                                  final _authresult = await _auth.signIn(
                                      _email.trim(), _password.trim());

                                  toggleProgressHUD(false, progress);
                                  Navigator.pushReplacementNamed(
                                      context, UserHome.id,arguments: _authresult.user.uid);                                } catch (e) {
                                  toggleProgressHUD(false, progress);

                                  // ignore: deprecated_member_use
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(e.toString()),
                                  ));
                                  print(e.message);
                                }
                              }
                              toggleProgressHUD(false, progress);
                            },
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
