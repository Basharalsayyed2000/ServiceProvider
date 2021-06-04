import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';

class CustomButton extends StatefulWidget{
  final String textValue;
  final double elevation;
  final Color color;
  final Function onPressed;

  CustomButton({@required this.onPressed, @required this.textValue, this.elevation,this.color});
  
  State<StatefulWidget> createState(){
    return _CustomButton(onPressed: onPressed, textValue: textValue, elevation: elevation,color:color);
  }
}

class _CustomButton extends State<CustomButton>{
  final String textValue;
  final double elevation;
  final Function onPressed;
  final Color color;

  _CustomButton({@required this.onPressed, @required this.textValue, this.elevation,this.color});
  
  Widget build(BuildContext context){
    // ignore: deprecated_member_use
    return RaisedButton(
      elevation: (elevation == null)? 4 : elevation,
      color: (color==null)?KfocusColor:color,
      padding: EdgeInsets.all(Kminimumpadding * 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: KfocusColor, width: 2)
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