import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/Screens/Provider/Navbar.dart';
import 'package:service_provider/Screens/Provider/ProviderSignUpScreen.dart';

import 'package:service_provider/Screens/commonScreens/ResetPassword.dart';
import 'package:service_provider/Services/auth.dart';

// ignore: must_be_immutable
class ProviderLoginScreen extends StatelessWidget {
  static String id = 'ProviderLoginScreen';
  // ignore: unused_field
  String _email, _password;

  // ignore: unused_field
  final _auth = Auth();
  // ignore: unused_field
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
              Padding(
                padding: EdgeInsets.only(
                  top: Kminimumpadding * 6.5,
                  bottom: Kminimumpadding * 1.5,
                  left: Kminimumpadding * 4.5,
                  right: Kminimumpadding * 4.5,
                ),
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
              Padding(
                padding: EdgeInsets.only(
                  top: Kminimumpadding * 1.5,
                  bottom: Kminimumpadding * 1.5,
                  left: Kminimumpadding * 4.5,
                  right: Kminimumpadding * 4.5,
                ),
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
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ResetPassword.id,
                  );
                },
                child: Container(
                  alignment: Alignment(0.8, 0.0),
                  padding: EdgeInsets.only(top: 0.0, left: 20.0),
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
                height: MediaQuery.of(context).size.height * .0605,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: Kminimumpadding * 1.5,
                  bottom: Kminimumpadding * 1.5,
                  left: Kminimumpadding * 4.5,
                  right: Kminimumpadding * 4.5,
                ),
                child: Builder(
                  builder: (context) => CustomButton(
                    textValue: "LOGIN",
                    onPressed: () async {
                      final _progress = ProgressHUD.of(context);
                      toggleProgressHUD(true, _progress);

                      if (_globalKey.currentState.validate()) {
                        _globalKey.currentState.save();
                        try {
                          final _authresult = await _auth.signIn(
                              _email.trim(), _password.trim());
                          String userId = _authresult.user.uid;
                          // ignore: unrelated_type_equality_checks
                          if (await _auth.checkProviderExist(userId) == true) {
                            // ignore: await_only_futures
                            // await _userStore.updateProviderPassword( _password,userId);
                            await Firestore.instance
                                .collection(KProviderCollection)
                                .document(userId)
                                .updateData({KProviderPassword: _password});
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                Navbar.id,
                                (Route<dynamic> route) => false,
                                arguments: _authresult.user.uid);
                          } else {
                            // ignore: deprecated_member_use
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('This account is for User'),
                            ));
                          }

                          toggleProgressHUD(false, _progress);
                        } catch (e) {
                          toggleProgressHUD(false, _progress);
                          // ignore: deprecated_member_use
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(e.message),
                          ));
                        }
                      }
                      toggleProgressHUD(false, _progress);
                    },
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
                      Navigator.pushReplacementNamed(
                        context,
                        ProviderSignUpScreen.id,
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
        ),
      ),
    );
  }

  void toggleProgressHUD(_loading, _progressHUD) {
    if (_loading) {
      _progressHUD.show();
    } else {
      _progressHUD.dismiss();
    }
  }

}
