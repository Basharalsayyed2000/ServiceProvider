import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/Services/auth.dart';

class ResetPassword extends StatefulWidget {
  static String id = "ResetPassword";
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String _email;
  final _auth = Auth();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        backgroundColor: KprimaryColor,
      ),
      body: ProgressHUD(
        child: Form(
          key: _globalKey,
          child: Column(
            children: <Widget>[
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
                    textValue: "Send Request",
                    onPressed: () async {
                      final _progress = ProgressHUD.of(context);
                      toggleProgressHUD(true, _progress);

                      if (_globalKey.currentState.validate()) {
                        _globalKey.currentState.save();
                        try {
                          await _auth.sendRequestToResetPassword(_email);
                          _globalKey.currentState.reset();
                          toggleProgressHUD(false, _progress);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("successfully send"),
                                  actions: [
                                    // ignore: deprecated_member_use
                                    RaisedButton(
                                      onPressed: () => Navigator.pop(context),
                                      color: KprimaryColor,
                                      child: Text("ok"),
                                    ),
                                  ],
                                );
                              });
                        } catch (e) {
                          toggleProgressHUD(false, _progress);
                          // ignore: deprecated_member_use
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(e.message),
                          ));
                        }
                        toggleProgressHUD(false, _progress);
                      }
                    },
                  ),
                ),
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
