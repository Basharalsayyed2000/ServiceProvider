import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';

class CustomButton extends StatefulWidget{
  final String textValue;
  final double elevation;
  final Function onPressed;

  CustomButton({@required this.onPressed, @required this.textValue, this.elevation});
  
  State<StatefulWidget> createState(){
    return _CustomButton(onPressed: onPressed, textValue: textValue, elevation: elevation);
  }
}

class _CustomButton extends State<CustomButton>{
  final String textValue;
  final double elevation;
  final Function onPressed;

  _CustomButton({@required this.onPressed, @required this.textValue, this.elevation});
  
  Widget build(BuildContext context){
    return RaisedButton(
      elevation: (elevation == null)? 4 : elevation,
      color: accentColor,
      padding: EdgeInsets.all(minimumpadding * 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: accentColor)
      ),
      
      child: Text(
        textValue,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24
        ),
      ),
      onPressed: onPressed,
      
    );
  }
}