import 'package:flutter/material.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';

class ChangeEmail extends StatefulWidget {
  static String id = "changeEmail";
  final bool isUser;
  ChangeEmail({this.isUser});
  
  @override
  State<StatefulWidget> createState() {
    return _ChangeEmail(
      isUser: (isUser!=null)?isUser:false,
    );
  }

}

class _ChangeEmail extends State<ChangeEmail> {
  final bool isUser;
  _ChangeEmail({this.isUser});
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