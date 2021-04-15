import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';

class CustomTextField extends StatefulWidget {
  /// Text that describes the input field.
  ///
  /// When the input field is empty and unfocused, the label is displayed on top of the input field (i.e., at the same
  /// location on the screen where text may be entered in the input field). When the input field receives focus (or if
  /// the field is non-empty), the label moves above (i.e., vertically adjacent to) the input field.
  final String labelText;

  /// Text that suggests what sort of input the field accepts.
  ///
  /// Displayed on top of the [InputDecorator.child] (i.e., at the same location
  /// on the screen where text may be entered in the [InputDecorator.child])
  /// when the input [isEmpty] and either (a) [labelText] is null or (b) the
  /// input has the focus.
  final String hintText;

  final IconData prefixIcon;

  final String prefixText;

  final Function onClicked;

  final bool iconBlank;

  CustomTextField(
      {@required this.onClicked,
      @required this.labelText,
      this.hintText,
      this.prefixIcon,
      this.prefixText,
      this.iconBlank});

  @override
  State<StatefulWidget> createState() {
    return _CustomTextField(
      onClicked: this.onClicked,
      labelText: this.labelText,
      hintText: this.hintText,
      prefixIcon: this.prefixIcon,
      prefixText: this.prefixText,
      iconBlank: this.iconBlank,
    );
  }
}

class _CustomTextField extends State<CustomTextField> {
  final String prefixText;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final Function onClicked;
  final bool iconBlank;

  Color _color;
  Color _iconColor = KprimaryColorDark;
  FontWeight _weight;

  _CustomTextField(
      {@required this.onClicked,
      @required this.labelText,
      this.hintText,
      this.prefixIcon,
      this.prefixText,
      this.iconBlank});

  // ignore: missing_return
  String _errorMessage(String str) {
    switch (labelText) {
      case "Full Name":
        return "Name is empty !";
      case "Password":
        return "Password is empty !";
      case "Name":
        return "Name is empty !";
      case "Email / Phone Number":
        return "Email / Phone Number is empty !";
      case "Confirm Password":
        return "Confirm Password is empty !";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.prefixIcon != null || this.iconBlank == true) {
      return Container(
        height: 55.0,
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
            obscureText: labelText=='Password'?true :false,
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) return _errorMessage(labelText);
            },

            onSaved: onClicked,

            decoration: InputDecoration(
              //textLabel and hintText values
              labelText: this.labelText,
              hintText: this.hintText,

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
          padding: EdgeInsets.only(
              top: Kminimumpadding * 1.35, bottom: Kminimumpadding * 1.35),
          height: Kheight,
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

              // ignore: missing_return
              validator: (value) {
                if (value.isEmpty) return 'value cant be empty';
              },

              onSaved: onClicked,

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
          height: 55.0,
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
              autofocus: false,

              // ignore: missing_return
              validator: (value) {
                if (value.isEmpty) return 'value cant be empty';
              },

              onSaved: onClicked,

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
