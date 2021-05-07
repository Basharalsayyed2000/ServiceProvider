import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;

  final String labelText;

  final String hintText;

  final IconData prefixIcon;

  final String prefixText;

  final TextInputType keyboardType;

  final Function(String) validator;

  final bool obscureText;

  final Function onClicked;

  final bool iconBlank;

  final bool enabled;

  final int minLines;

  final int maxLines;

  final int maxLength;
 

  CustomTextField(
      {@required this.onClicked,
        @required this.labelText,
        this.obscureText,
        this.validator,
        this.keyboardType,
        this.hintText,
        this.prefixIcon,
        this.prefixText,
        this.iconBlank,
        this.controller,
        this.minLines,
        this.maxLines,
        this.maxLength,
        this.enabled,
        });

  @override
  State<StatefulWidget> createState() {

    return _CustomTextField(
      onClicked: this.onClicked,
      labelText: this.labelText,
      validator: this.validator,
      hintText: this.hintText,
      obscureText: (this.obscureText == null) ? false : this.obscureText,
      keyboardType: (this.keyboardType == null) ? TextInputType.text : this.keyboardType,
      prefixIcon: this.prefixIcon,
      prefixText: this.prefixText,
      iconBlank: this.iconBlank,
      controller: this.controller,
      minLines: (this.minLines == null) ? 1 : this.minLines,
      maxLines: (this.maxLines == null) ? (this.minLines == null) ? 1 : this.minLines : this.maxLines,
      maxLength: this.maxLength,
      enabled: this.enabled,
    );
  }
}

class _CustomTextField extends State<CustomTextField> {
  final String prefixText;
  final String labelText;
  final Function(String) validator;
  final TextInputType keyboardType;
  final String hintText;
  final IconData prefixIcon;
  final Function onClicked;
  final bool enabled;
  final bool iconBlank;
  final bool obscureText;
  final TextEditingController controller;
  final int minLines;
  final int maxLines;
  final int maxLength;

  bool _passwordVisible = false;
  bool _isObscure;
 

  Color _color;
  Color _iconColor = KprimaryColorDark;
  FontWeight _weight;

  _CustomTextField(
      {@required this.onClicked,
        @required this.labelText,
        @required this.keyboardType,
        this.obscureText,
        this.validator,
        this.hintText,
        this.prefixIcon,
        this.prefixText,
        this.iconBlank,
        this.controller,
        this.minLines,
        this.maxLines,
        this.maxLength,
        this.enabled,
       });

  // ignore: missing_return
  String _errorMessage(String str) {
    switch (labelText) {
      case "Full Name":
        return "Name is empty !";
      case "Password":
        return "Password is empty !";
      case "Name":
        return "Name is empty !";
      case "Email":
        return "Email is empty !";
      case "Confirm Password":
        return "Confirm Password is empty !";   
      case "Phone Number":
        return "Phone Number is empty !";
      
    }
  }

  @override
  void initState() {
    _isObscure = this.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (this.prefixIcon != null || this.iconBlank == true) {
      return SizedBox(
        height: 73,
        child: Focus(
          //function comes with Focus Widget
          //gives a bool hasFocus variable used to track textField focus state
          onFocusChange: (hasFocus) {
            //updates when the state changes
            setState(() {
              _color = hasFocus ? KprimaryColorDark : null;
              _iconColor = hasFocus ? KdisabledColor : KprimaryColorDark;
              _weight = hasFocus ? FontWeight.bold : null;
            });
          },

          child: TextFormField(
            autofocus: false,
            obscureText: _isObscure,
            enabled: this.enabled,

            // ignore: missing_return
            validator: (value) => value.isEmpty ? _errorMessage(labelText) : null,
            
            keyboardType: TextInputType.multiline,
           // expands: true, 
            onSaved: onClicked,

            minLines: this.minLines,
            maxLines: this.maxLines,

            maxLength: this.maxLength,

            decoration: InputDecoration(
            
              //textLabel and hintText values
              labelText: this.labelText,
              hintText: this.hintText,
              suffixIcon: this.obscureText ? IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  semanticLabel: _passwordVisible ? 'hide password' : 'show password',
                ),
                onPressed: (){
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                    _isObscure = !_isObscure;
                  });
                },
              ) : null,
              isDense: true,
              

              //PrefixIcon with Design
              prefixIcon: Icon(
                this.prefixIcon,
                color: _iconColor,
              ),

              //textLabel Design
              labelStyle: TextStyle(
                color: _color,
                fontWeight: _weight,
              ),

              //idle border Design
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: KdisabledColor, width: 1.5),
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: KdisabledColor, width: 1.5),
              ),

              //when textField is focused Design
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: KfocusColor, width: 2.5),
              ),
            ),
          ),
        ),
      );
    } else {
      if (this.prefixText == null) {
        return Container(
          child: Focus(
            //function comes with Focus Widget
            //gives a bool hasFocus variable used to track textField focus state
            onFocusChange: (hasFocus) {
              //updates when the state changes
              setState(() {
                _color = hasFocus ? KprimaryColorDark : null;
                _weight = hasFocus ? FontWeight.bold : null;
              });
            },

            child: TextFormField(
              autofocus: false,

              enabled: this.enabled,

              // ignore: missing_return
              validator: (value) => value.isEmpty ? _errorMessage(labelText) : null,

              onSaved: onClicked,

              minLines: this.minLines,
              maxLines: this.maxLines,

              maxLength: this.maxLength,

              decoration: InputDecoration(
                //textLabel and hintText values
                labelText: this.labelText,
                hintText: this.hintText,

                //textLabel Design
                labelStyle: TextStyle(
                  color: _color,
                  fontWeight: _weight,
                ),

                //idle border Design
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: KdisabledColor, width: 1.5),
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: KdisabledColor, width: 1.5),
                ),

                //when textField is focused Design
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: KfocusColor, width: 2.5),
                ),
              ),
            ),
          ),
        );
      } else {
        return Container(

          child: Focus(
            //function comes with Focus Widget
            //gives a bool hasFocus variable used to track textField focus state
            onFocusChange: (hasFocus) {
              //updates when the state changes
              setState(() {
                _color = hasFocus ? KprimaryColorDark : null;
                //_weight = hasFocus ? FontWeight.bold : null;
              });
            },

            child: TextFormField(
              keyboardType: this.keyboardType,

              autofocus: false,

              enabled: this.enabled,

              // ignore: missing_return
              validator: (value) => value.isEmpty ? _errorMessage(labelText) : null,

              onSaved: onClicked,

              minLines: this.minLines,
              maxLines: this.maxLines,

              maxLength: this.maxLength,

              decoration: InputDecoration(
                //textLabel and hintText values
                labelText: this.labelText,
                hintText: this.hintText,
                //prefixText: this.prefixText,

                //textLabel Design
                labelStyle: TextStyle(
                  color: _color,
                  fontWeight: _weight,
                ),

                prefixStyle: TextStyle(
                  fontWeight: _weight,
                  color: _color,
                ),

                //idle border Design
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: KdisabledColor, width: 1.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: KdisabledColor, width: 1.5),
                ),
                //when textField is focused Design
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: KfocusColor, width: 2.5),
                ),
              ),
            ),
          ),
        );
      }
    }
  }
}
