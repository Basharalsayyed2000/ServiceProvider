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

  PasswordDialog({this.changeEmail});

  @override
  State<StatefulWidget> createState() {
    return _PasswordDialog(
        changeEmail: (changeEmail == null) ? false : changeEmail);
  }
}

class _PasswordDialog extends State<PasswordDialog> {
  final _auth = Auth();
  final bool changeEmail;
  String _currentPassword;
  String userId;
  String myPassword;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  _PasswordDialog({this.changeEmail});
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
        .collection(KUserCollection)
        .document(await _auth.getCurrentUserId())
        .get()
        .then((value) {
      setState(() {
        myPassword = value.data[KUserPassword];
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
          height: MediaQuery.of(context).size.height/2.3,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                margin: EdgeInsets.only(bottom: 30, left: 10, right: 10),

                child: CustomTextField(
                  prefixIcon: Icons.vpn_key,
                  labelText: "Current Password",
                  obscureText: true,
                  validator: (value) {
                    print(value);
                    if (value == "") {
                      return "The Password Field Can't Be Empty!";
                    } else {
                      if (value != myPassword) {
                        return "The Password Is Incorrect";
                      } else {
                        changeEmail
                            ? Navigator.of(context)
                                .pushReplacementNamed(ChangeEmail.id)
                            : Navigator.of(context)
                                .pushReplacementNamed(ChangePassword.id);
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
                  //   _globalKey.currentState.save();
                  //   if (_currentPassword == myPassword) {

                  //   } else {

                  //   }
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
  static exit(context, changeEmail) => showDialog(
      context: context,
      builder: (context) => PasswordDialog(changeEmail: changeEmail));
}
