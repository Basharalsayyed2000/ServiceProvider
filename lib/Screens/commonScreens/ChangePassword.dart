import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';

class ChangePassword extends StatefulWidget {
  static String id = "changePassword";

  @override
  State<StatefulWidget> createState() {
    return _ChangePassword();
  }

}

class _ChangePassword extends State<ChangePassword> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.07),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                child: CustomTextField(
                  prefixIcon: Icons.vpn_key,
                  obscureText: true,
                  labelText: "New Password",
                  onClicked: (value){}, 
                ),
              ),

              Container(
                child: CustomTextField(
                  prefixIcon: Icons.vpn_key,
                  obscureText: true,
                  labelText: "Confirm Password",
                  onClicked: (value){}, 
                ),
              ),

              Container(
                width: 220,
                margin: EdgeInsets.only(top: 5),
                child: CustomButton(
                  textValue: "Change Password",
                  onPressed: (){}, 
                ),
              ),

            ],
          ),
        ),
      )
    );
  }

}