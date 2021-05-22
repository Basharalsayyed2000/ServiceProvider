import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/Screens/commonScreens/ChangeEmail.dart';
import 'package:service_provider/Screens/commonScreens/ChangePassword.dart';

class PasswordDialog extends StatefulWidget{

  final bool changeEmail;

  PasswordDialog({this.changeEmail});

  @override
  State<StatefulWidget> createState(){
    return _PasswordDialog(changeEmail: (changeEmail == null)? false : changeEmail);
  }

}

class _PasswordDialog extends State<PasswordDialog>{

  final bool changeEmail;

  _PasswordDialog({this.changeEmail});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25)
      ),
      backgroundColor: Colors.white.withOpacity(1),
      elevation: 8,
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 30, left: 10, right: 10),
            child: CustomTextField(
              prefixIcon: Icons.vpn_key,
              labelText: "Current Password",
              obscureText: true,
              onClicked: (value){
                //CODE TO VALIDATE PASSWORD
              }, 
            ),
          ),
          
          CustomButton(
            elevation: 10,
            onPressed: (){
              changeEmail? Navigator.of(context).pushReplacementNamed(ChangeEmail.id) : Navigator.of(context).pushReplacementNamed(ChangePassword.id);
            }, 
            textValue: "Verify"
          )
          
        ],
      ),
    );
  }

}

class DialogHelper{
  static exit(context, changeEmail) => showDialog(context: context, builder: (context) => PasswordDialog(changeEmail: changeEmail));

}