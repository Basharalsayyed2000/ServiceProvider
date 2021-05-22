import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';

class ChangeEmail extends StatefulWidget {
  static String id = "changeEmail";

  @override
  State<StatefulWidget> createState() {
    return _ChangeEmail();
  }

}

class _ChangeEmail extends State<ChangeEmail> {

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
                  prefixIcon: Icons.mail,
                  labelText: "E-mail",
                  onClicked: (value){}, 
                ),
              ),

              Container(
                width: 220,
                margin: EdgeInsets.only(top: 5),
                child: CustomButton(
                  textValue: "Change Email",
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