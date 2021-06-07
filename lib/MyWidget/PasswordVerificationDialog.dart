import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/Screens/commonScreens/ChangeEmail.dart';
import 'package:service_provider/Screens/commonScreens/ChangePassword.dart';
import 'package:service_provider/Services/auth.dart';

class PasswordDialog extends StatefulWidget {
  final bool changeEmail;
  final bool isUser;

  PasswordDialog({@required this.changeEmail, @required this.isUser});

  @override
  State<StatefulWidget> createState() {
    return _PasswordDialog(
        changeEmail: (changeEmail == null) ? false : changeEmail,
        isUser: isUser);
  }
}

class _PasswordDialog extends State<PasswordDialog> {
  final _auth = Auth();
  final bool changeEmail;
  String currentPassword;
  String userId;
  final bool isUser;
  String myPassword;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  _PasswordDialog({this.changeEmail, this.isUser});
  @override
  void initState() {
    super.initState();
    getUserId();
    getUserName();
  }

  getUserId() async {
    String value = await _auth.getCurrentUserId();
    setState(() {
      userId = value;
    });
  }

  Future<void> getUserName() async {
    Firestore.instance
        .collection((isUser)?KUserCollection:KProviderCollection)
        .document(await _auth.getCurrentUserId())
        .get()
        .then((value) {
      setState(() {
        myPassword = value.data[(isUser)?KUserPassword:KProviderPassword];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      backgroundColor: Colors.white.withOpacity(1),
      elevation: 8,
      child: Form(
        key: _globalKey,
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 2.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 30, left: 10, right: 10),
                child: CustomTextField(
                  prefixIcon: Icons.vpn_key,
                  labelText: "Current Password",
                  obscureText: true,
                  // ignore: missing_return
                  validator: (value) {
                    print(value);
                    if (value == "") {
                      return "The Password Field Can't Be Empty!";
                    } else {
                      if (value != myPassword) {
                        return "The Password Is Incorrect";
                      } else {
                        changeEmail
                            ? 
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => ChangeEmail(isUser:isUser,)),
                           )
                          : Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => ChangePassword(isUser:isUser,)),
                          );
                      }
                    }
                  },
                  onClicked: (value) {},
                ),
              ),
              CustomButton(
                elevation: 10,
                onPressed: () async {
                  _globalKey.currentState.validate();
                },
                textValue: "Verify",
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DialogHelper {
  static exit(context, changeEmail,isUser) => showDialog(
      context: context,
      builder: (context) => PasswordDialog(changeEmail: changeEmail,isUser: isUser,));
}
