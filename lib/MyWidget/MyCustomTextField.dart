import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';


class CustomTextFied extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClicked;
  final Widget child;
  CustomTextFied({@required this.onClicked,@required this.hint,@required this.icon,this.child});
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              // ignore: missing_return
              validator: (value){
                 if(value.isEmpty)
                 return 'value cant be empty';

              },
              onSaved: onClicked,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                hintText: "$hint",
                prefixIcon: Icon(
                  this.icon,
                  color: primaryColor,
                ),
                fillColor: primaryColor,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          );
  }
}