import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/Services/auth.dart';

class ChangePassword extends StatefulWidget {
  static String id = "changePassword";

  @override
  State<StatefulWidget> createState() {
    return _ChangePassword();
  }
}

class _ChangePassword extends State<ChangePassword> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String newPasswd, confirmPasswd, userId;
  Auth _auth;

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  getUserId() async {
    String _userId = (await FirebaseAuth.instance.currentUser()).uid;
    setState(() {
      userId = _userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
      child: Form(
        key: _globalKey,
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.07),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: CustomTextField(
                    prefixIcon: Icons.vpn_key,
                    obscureText: true,
                    labelText: "New Password",
                    validator: (value) {
                      return (value == null)
                          ? "Please enter your new Password!"
                          : ((value.length < 10)
                              ? "The Password must be 10 characters minimum"
                              : null);
                    },
                    onClicked: (value) {
                      setState(() {
                        newPasswd = value;
                      });
                    },
                  ),
                ),
                Container(
                  child: CustomTextField(
                    prefixIcon: Icons.vpn_key,
                    obscureText: true,
                    labelText: "Confirm Password",
                    validator: (value) {
                      return (value == null)
                          ? "Please enter your new Password!"
                          : ((value.length < 10)
                              ? "The Password must be 10 characters minimum"
                              : null);
                    },
                    onClicked: (value) {
                      setState(() {
                        confirmPasswd = value; 
                      });
                    },
                  ),
                ),
                Container(
                  width: 220,
                  margin: EdgeInsets.only(top: 5),
                  child: Builder(
                    builder: (context) => CustomButton(
                      textValue: "Change Password",
                      onPressed: () async {
                        final _progress = ProgressHUD.of(context);
                        toggleProgressHUD(true, _progress);

                        print("value ${_globalKey.currentState.validate()}");

                        if (_globalKey.currentState.validate()) {
                          _globalKey.currentState.save();
                           print(newPasswd);
                          try {
                            if (newPasswd == confirmPasswd) {
                              // await Firestore.instanc
                              //     .collection(KUserCollection)
                              //     .document(userId)
                              //     .updateData({KUserPassword: newPasswd});
                            } else {
                              // ignore: deprecated_member_use
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("password doesn't match"),
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
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void toggleProgressHUD(_loading, _progressHUD) {
    setState(() {
      if (!_loading) {
        _progressHUD.dismiss();
      } else {
        _progressHUD.show();
      }
    });
  }
}
